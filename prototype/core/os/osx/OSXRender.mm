/********************************************************************
 *             a  A                                                        
 *            AM\/MA                                                         
 *           (MA:MMD                                                         
 *            :: VD
 *           ::  º                                                         
 *          ::                                                              
 *         ::   **      .A$MMMMND   AMMMD     AMMM6    MMMM  MMMM6             
 +       6::Z. TMMM    MMMMMMMMMDA   VMMMD   AMMM6     MMMMMMMMM6            
 *      6M:AMMJMMOD     V     MMMA    VMMMD AMMM6      MMMMMMM6              
 *      ::  TMMTMC         ___MMMM     VMMMMMMM6       MMMM                   
 *     MMM  TMMMTTM,     AMMMMMMMM      VMMMMM6        MMMM                  
 *    :: MM TMMTMMMD    MMMMMMMMMM       MMMMMM        MMMM                   
 *   ::   MMMTTMMM6    MMMMMMMMMMM      AMMMMMMD       MMMM                   
 *  :.     MMMMMM6    MMMM    MMMM     AMMMMMMMMD      MMMM                   
 *         TTMMT      MMMM    MMMM    AMMM6  MMMMD     MMMM                   
 *        TMMMM8       MMMMMMMMMMM   AMMM6    MMMMD    MMMM                   
 *       TMMMMMM$       MMMM6 MMMM  AMMM6      MMMMD   MMMM                   
 *      TMMM MMMM                                                           
 *     TMMM  .MMM                                         
 *     TMM   .MMD       ARBITRARY·······XML········RENDERING                           
 *     TMM    MMA       ====================================                              
 *     TMN    MM                               
 *      MN    ZM                       
 *            MM,
 *
 * 
 *      AUTHORS: Miro Keller
 *      
 *      COPYRIGHT: ©2011 - All Rights Reserved
 *
 *      LICENSE: see License.txt file
 *
 *      WEB: http://axr.vg
 *
 *      THIS CODE AND INFORMATION ARE PROVIDED "AS IS"
 *      WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
 *      OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 *      IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR
 *      FITNESS FOR A PARTICULAR PURPOSE.
 *
 ********************************************************************
 *
 *      FILE INFORMATION:
 *      =================
 *      Last changed: 2011/04/21
 *      HSS version: 1.0
 *      Core version: 0.3
 *      Revision: 2
 *
 ********************************************************************/

#include "OSXRender.h"
#import <Cocoa/Cocoa.h>
#include <cairo/cairo-quartz.h>
#include "../../axr/AXRController.h"
#include "../../hss/objects/HSSContainer.h"
#include "../../hss/parsing/HSSRule.h"
#include <iostream>
#include "../../axr/AXRDebugging.h"

using namespace AXR;

OSXRender::OSXRender(AXRController * controller)
: AXRRender(controller)
{
    
}

OSXRender::~OSXRender()
{
    
}

void OSXRender::drawInRectWithBounds(AXRRect rect, AXRRect bounds)
{
    //FIXME: is there a more elegant way to transport rectangle data?
    //eg. inline function, x,y,width,height arguments, etc
    [[NSColor whiteColor] set];
    NSRect boundsRect;
    boundsRect.size.width = bounds.size.width;
    boundsRect.size.height = bounds.size.height;
    boundsRect.origin.x = bounds.origin.x;
    boundsRect.origin.y = bounds.origin.y;
    NSRectFill(boundsRect);
    
    
    CGContextRef ctxt = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    //invert the coordinate system
    CGContextTranslateCTM (ctxt, 0.0, (int)bounds.size.height);
    CGContextScaleCTM (ctxt, 1.0, -1.0);
    
    cairo_surface_t * targetSurface = cairo_quartz_surface_create_for_cg_context(ctxt, rect.size.width, rect.size.height);
    cairo_t * tempcairo = cairo_create(targetSurface);
    cairo_surface_destroy(targetSurface);
    
    this->cairo = tempcairo;
    AXRRender::drawInRectWithBounds(rect, bounds);
    cairo_destroy(this->cairo);
    this->cairo = NULL;

}





