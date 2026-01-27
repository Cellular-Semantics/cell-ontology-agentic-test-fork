# Curation Report: Bone Marrow Adipocyte

Thank you for submitting this term request. I've completed a comprehensive literature review and validation of the proposed term. Here are my findings:

## ⚠️ Important Finding: Reference Issue

**PMID:31899563 is NOT relevant to this term request.** This paper is about "Molecular mechanisms of vancomycin resistance" (bacterial antibiotic resistance) and is completely unrelated to bone marrow adipocytes. This appears to be an error and should be removed from the reference list.

The relevant PMIDs are:
- ✅ **PMID:34912805** - Comprehensive review on bone marrow adipocytes
- ✅ **PMID:32286228** - Single-cell transcriptomics study defining BMAs and MALPs

## Validated Definition

Based on the literature review, I propose the following definition:

> **A mature, lipid-laden adipocyte that resides in the bone marrow cavity and is derived from bone marrow mesenchymal stromal cells. This cell type is developmentally and functionally distinct from white, brown, and beige adipocytes. Bone marrow adipocytes are metabolically active cells with abundant lipid stores, mitochondria, and endoplasmic reticulum, and serve critical regulatory roles in hematopoiesis, osteogenesis, osteoclastogenesis, and immune regulation within the bone marrow microenvironment.**

**Supporting references**: PMID:34912805, PMID:32286228

## Validated Metadata

### Parent Term
- **is_a**: adipocyte (CL:0000136) ✅ CONFIRMED

### Synonyms
- ✅ **EXACT**: "marrow adipocyte" (validated in both PMIDs)
- ✅ **EXACT**: "BMA" (standard abbreviation)
- ❌ **REJECT**: "adipocyte" alone - This is too broad; adipocyte is the parent class, not a synonym

### Anatomical Location
- **part_of**: bone marrow (UBERON:0002371) ✅ CONFIRMED

### Additional Relationships
Based on the literature, I recommend adding:

1. **develops_from**: bone marrow mesenchymal stromal cell (or similar CL term if it exists)
   - Evidence: "BMAs arise from bone marrow mesenchymal stromal cells (BMSCs)" (PMID:34912805)

2. **Functional capabilities** (if CL supports these annotations):
   - capable_of: regulation of hematopoiesis
   - capable_of: negative regulation of osteoblast differentiation
   - capable_of: positive regulation of osteoclast differentiation
   - capable_of: regulation of immune system process

## Key Distinguishing Features

From the literature analysis, bone marrow adipocytes are characterized by:
1. **Mature, lipid-laden state** with visible lipid droplets (Perilipin+)
2. **Bone marrow-specific location**
3. **Distinct from white/brown/beige adipocytes** in development and function
4. **Derived from bone marrow mesenchymal stromal cells**, not from other adipocyte lineages
5. **Critical regulatory functions** in hematopoiesis, bone remodeling, and immunity

## 🔍 Important: Precursor Cell Type

The literature (especially PMID:32286228) identifies a distinct **precursor cell type** called **"marrow adipogenic lineage precursor" (MALP)** that:
- Expresses adipocyte markers (adiponectin+)
- **Lacks lipid droplets** (key distinction from mature BMAs)
- Functions as pericytes and stromal cells
- Differentiates into mature bone marrow adipocytes

**Recommendation**: Should we also create "marrow adipogenic lineage precursor" (MALP) or "bone marrow preadipocyte" as a **separate term**? This would be analogous to having both osteoblast and osteocyte terms. The relationship would be:

MALP → differentiates_into → bone marrow adipocyte (mature)

## Literature Summary

### PMID:34912805 (Wang et al., 2021)
Comprehensive review establishing that:
- BMAs are "developmentally and functionally distinct from classical white, brown, and beige adipocytes"
- BMAs are "derived from bone marrow mesenchymal stromal cells"
- BMAs have "abundant lipid stores, mitochondria, and endoplasmic reticulum"
- BMAs regulate "hematopoiesis, osteogenesis, osteoclastogenesis, and immune regulation"
- First described in 1922, but only recently well-characterized

### PMID:32286228 (Zhong et al., 2020)
Single-cell transcriptomics study demonstrating:
- Clear differentiation pathway: mesenchymal progenitors → MALPs → lipid-laden adipocytes (LiLAs/BMAs)
- BMAs are the terminal, mature form with lipid accumulation
- MALPs (non-lipid-laden precursors) are a distinct cell type
- Both play roles in bone marrow microenvironment regulation

## Confidence Level: HIGH

All aspects of this term are well-supported by high-quality literature:
- ✅ Definition supported by multiple independent studies
- ✅ Parent term clearly established
- ✅ Anatomical location unambiguous
- ✅ Synonyms consistently used across literature
- ✅ Functional roles well-documented
- ✅ ~100 years of literature, with major advances in last decade

## Recommendation

**✅ APPROVED FOR INTEGRATION INTO CL**

This term represents a distinct, well-characterized, physiological cell type appropriate for the Cell Ontology. I recommend creating the term with:
- The definition provided above
- Parent: adipocyte (CL:0000136)
- Synonyms: "marrow adipocyte" and "BMA" (reject "adipocyte" alone)
- References: PMID:34912805, PMID:32286228 (exclude PMID:31899563)
- Location: part_of bone marrow (UBERON:0002371)

Please let me know if you'd like me to also curate "marrow adipogenic lineage precursor" (MALP) as a companion term, or if you have any questions about this curation.
