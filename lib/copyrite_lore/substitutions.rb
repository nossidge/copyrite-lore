#!/usr/bin/env ruby
# Encoding: UTF-8

################################################################################
# Substitute tech terms for Wiccan terms.
# Just a class method on the main module.
################################################################################

module CopyriteLore

  def self.substitutions
    @@substitutions ||= {
      ' a information' => ' an information',
      'method' => 'magick',
      'magickology' => 'magick',
      'system' => 'ritual',
      'data' => 'aura',
      'aurabase' => 'aura',
      'aura base' => 'aura',
      ' a aura' => ' an aura',
      'file' => 'rite',
      'rited' => 'filed',
      'prorite' => 'profile',
      'aurarites' => 'aura-rites',
      'apparatus' => 'alembics',
      ' an alembics' => ' an alembic',
      'machine' => 'spirit',
      'machining' => 'transfigurating',
      'binary' => 'demonic',
      'garbage' => 'essence',
      'outputting' => 'manifesting',
      'output' => 'manifestation',
      'message' => 'incantation',
      'document' => 'spell',
      'program' => 'charm',
      'charmmable' => 'charmable',
      'nc ' => 'circle magick ',
      'remote' => 'ethereal',
      ' a ethereal' => ' an ethereal',
      'testing' => 'annointing',
      'hardware' => 'circle',
      'software' => 'enchantment',
      ' a enchantment' => ' an enchantment',
      'logic controller' => 'poppet effigy',
      'effigys' => 'effigies',
      'scanning' => 'scrying',
      'character' => 'glyph',
      'glyphi' => 'characteri',
      'string' => 'tome',
      'codebook' => 'grimoire',
      'source code' => 'grimoire',
      'telecommunications' => 'subconscious',
      'telecommunication' => 'subconscious',
      'telephone' => 'subconscious',
      'subconsciouss' => 'subconscious',
      'neural' => 'neutral',
      'network' => 'coven',
      'computer' => 'ceremony',
      'ceremonys' => 'ceremonies',
      'ceremonyized' => 'ceremonial',
      'redundancy' => 'palmistry',
      'circuit' => 'altar',
      ' a altar' => ' an altar',
      'motorcycle' => 'broomstick',
      'simulation' => 'invocation',
      ' a invocation' => ' an invocation',
      'workstation' => 'cauldron',
      'ceremony cauldron' => 'ceremonial cauldron',
      'diskette' => 'crystal ball',
      'disk' => 'crystal ball',
      'crystal ball drive' => 'crystal ball',
      'device' => 'pentagram',
      'function' => 'convergence',
      'convergenceal' => 'convergent',
      'convergenceality' => 'convergence',
      'controller' => 'familiar',
      'cache' => 'aether',
      'aetherd' => 'aethered',
      ' a aether' => ' an aether',
      'virtual' => 'astral',
      ' a astral' => ' an astral',
      'computing' => 'divination',
      'divination the ' => 'divination of the ',
      'awk' => 'faerie',
      'generating' => 'conjuring',
      'generation' => 'conjuration',
      'processing' => 'focussing',
      'indexing' => 'consecrating',
      'numerical' => 'numerological',
      'communications coven' => 'skyclad coven',
      'communication' => 'communion',
      'communions' => 'communion',
    }
  end

end

################################################################################
