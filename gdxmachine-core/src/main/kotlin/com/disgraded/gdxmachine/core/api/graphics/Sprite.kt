package com.disgraded.gdxmachine.core.api.graphics

import com.badlogic.gdx.graphics.Texture
import com.badlogic.gdx.graphics.g2d.TextureRegion

class Sprite : Drawable(Type.SPRITE) {

    private var texture: TextureRegion? = null

    fun setTexture(textureRegion: TextureRegion) {
        texture = textureRegion
    }

    fun setTexture(texture: Texture) {
        this.texture = TextureRegion(texture)
    }

    fun getTexture(): TextureRegion? = texture

}