Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6518D636;
	Sun, 15 Mar 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595239; cv=pass; b=b6EIrwNG+IIBkPMeZj0pEC/sKaBDmfHQAKyJY3AyltBXEuQOXVnrvCvsWWoDLNeUU0Z/sh8rESnoS7Skk1BGHdXWusNhdZXGL/HYSdeNYmAnVnegghEWoswmhjyb8pxYZyySdaW/+1zfqMpmPCzNFwEYqjDd0rJSYrrNZzBCboc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595239; c=relaxed/simple;
	bh=K55wtWZSqGv3zAxJLr3Fh2w+ixwfaihg2qQx77goS5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TAdwaGu7LedqJ2JHjtRHAuHu/XhdzFo3RTpTFxRR+w80w2ijXQCTr58y6aH4zdx1SlMh2kJB69PJd9tqb+PgyDLpsiMEFtFb24SPfkT+5jhgaOYgrtRdyPhd3mkIIY81P93vBJFVb50j86YScLQk1L22Qg1rBsgNu+6vvSEsF3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=GnhKQq43; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="GnhKQq43"
ARC-Seal: i=1; a=rsa-sha256; t=1773595215; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kJIATKs81y9grr3r0rz/ldDm5kIuwRv1+O83p+X09d5Y4BI0/l0HjY1jQgmt4EcQEL+9UffD1ozSJkibpNqjC5jHwRzZPgnujWykRtDWI1NLyL5I7BKXlJ1OO57FMIXIhOIwxZCR7GNq91ZWfJjhhlAgz4TK58w/he8rHIaXe4c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773595215; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JEL6m7F7dkflN/duDHbZM3OlFIIRiM9YVFTbBlcnQjw=; 
	b=WeFgJSge5EGMx8D0RLFQBAzJkI4N8DQ6vXPSdgg+j3kJpIS2aXHUr65y0+jaVP60AR0vFnWOex/AXdJ8gvt9vR30SYMDe0Li+neFI44Une3jqLwUwPp+LogeyLVwAeOpNnlhhAu94GRjq+/hO4rNyyyaToxqriJC6qADLyCl2Ow=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773595215;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=JEL6m7F7dkflN/duDHbZM3OlFIIRiM9YVFTbBlcnQjw=;
	b=GnhKQq437lPGDo1dMBMR5MvYEwjUnhCKMb3pGplkjYWqVahMF+9e1YHrOqCtG34X
	WOxnbIvbMwvFBahbvr1UVAu7Mz2jFWS9CaGBhwHhci2uvwJUOmw5hfvB39k2HiS04xw
	xND4r8uOW33Cggl3fy8jTZDM9cMAxZ2OTWz+uCAU=
Received: by mx.zohomail.com with SMTPS id 1773595212938678.3821643884867;
	Sun, 15 Mar 2026 10:20:12 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v6 0/2] hfsplus: prevent b-tree allocator corruption
Date: Sun, 15 Mar 2026 22:50:03 +0530
Message-Id: <20260315172005.2066677-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi all,

This series addresses a Syzkaller-reported vulnerability where fuzzed
HFS+ images mark the B-tree Header Node (Node 0) as free in the
allocation bitmap. This violates a core filesystem invariant and
leads to allocator corruption and kernel panics.

To fix this safely and cleanly, the series is split into two parts:

Patch 1 introduces a unified API for B-tree map record access
(struct hfs_bmap_ctx, hfs_bmap_get_map_page, and hfs_bmap_clear_bit) and
refactors the boilerplate page mapping logic out of
hfs_bmap_alloc() and hfs_bmap_free().
Patch 2 utilizes this new API to perform a mount-time validation of
Node 0 via hfs_bmap_test_bit(), forcing a safe read-only mount if structural
or bit-level corruption is detected.

Note on Allocator Optimization: Following discussions in v4, there is
a recognized opportunity to optimize hfs_bmap_alloc() from a first-fit
to a next-fit allocator by caching an in-core allocation hint (roving
pointer) and bounding the scan with tree->node_count. To keep the
scope of this series strictly aligned with the Syzkaller corruption
fix, that architectural optimization is deferred to a separate,
follow-up patchset/thread.

Link: https://lore.kernel.org/all/20260228122305.1406308-1-shardul.b@mpiricsoftware.com/

v6:
 - Symmetric Mapping: Updated hfs_bmap_get_map_page() to return an unmapped
   struct page * instead of a mapped pointer. This ensures the caller
   explicitly handles both kmap_local_page() and kunmap_local(), preventing
   dangerous asymmetric mapping lifecycles.

 - Bisectability: Moved the introduction of hfs_bmap_test_bit() from Patch 1
   to Patch 2 where it is actually consumed, preventing a -Wunused-function
   compiler warning and keeping the Git history perfectly bisectable.

 - API Clarity: Renamed the bit_idx parameter to node_bit_idx in the bit-level
   helpers to explicitly clarify that the index is strictly relative to the
   target hfs_bnode's map record, preventing future absolute-index misuse.

 - Naming & Style: Replaced hardcoded 8s with BITS_PER_BYTE, updated local
   variable names (m to mask, data to bmap inside the new helpers), and added
   kernel-doc field descriptions to struct hfs_bmap_ctx.

 - Minimal Diff Scope: Restored the original variable names (data, m) inside
   the legacy hfs_bmap_alloc() loop to keep the diff surgically focused on the
   logical changes and preserve git blame history.

 - Error Codes: Changed the error return in hfs_bmap_clear_bit() from
   -EALREADY to -EINVAL.

 - CNID String Lookup: Replaced the sparse string array with #define macros 
   and a standard switch statement for cleaner subsystem visibility, per
   Slava's preference.


v5:
 - API Encapsulation: Introduced struct hfs_bmap_ctx to cleanly bundle
   offset, length, and page index state instead of passing multiple
   pointers, addressing reviewer feedback.

 - Bit-Level Helpers: Added hfs_bmap_test_bit() and hfs_bmap_clear_bit()
   to safely encapsulate mapping/unmapping for single-bit accesses
   (like the mount-time check and node freeing).

 - Performance Retention: Retained the page-level mapping approach for
   the linear scan inside hfs_bmap_alloc() to prevent the severe
   performance regression of mapping/unmapping on a per-byte basis,
   while refactoring it to use the new ctx struct.

 - Hexagon Overflow Fix: Fixed a 0-day Kernel Test Robot warning on
   architectures with 256KB page sizes by upgrading the offset variables
   in the new struct hfs_bmap_ctx to unsigned int, preventing 16-bit shift
   overflows.
   Link: https://lore.kernel.org/all/202602270310.eBmeD8VX-lkp@intel.com/

 - Map Record Spanning: Added a byte_offset parameter to the page mapper
   to correctly handle large map records that span across multiple 4KB
   pages.

 - Loop Mask Revert: Reverted the 0x80 bitmask in the alloc() inner loop
   back to its original state (and dropped the HFSPLUS_BTREE_NODE0_BIT
   macro), as it represents a generic sliding mask, not specifically
   Node 0.

 - String Array Cleanup: Replaced the verbose switch(id) block in the
   mount validation with a clean static array of constant strings for
   the CNID names, per reviewer feedback.

v4:
 - Split the changes into a 2-patch series (Refactoring + Bug Fix).
 - Extracted map node traversal into a generic helper (hfs_bmap_get_map_page)
   as per Slava's feedback, replacing manual offset/page management.
 - Added node-type validation (HFS_NODE_HEADER vs HFS_NODE_MAP) inside the
   helper to defend against structurally corrupted linkages.
 - Replaced hardcoded values with named macros (HFSPLUS_BTREE_NODE0_BIT, etc).
 - Handled invalid map offsets/lengths as corruption, continuing the mount
   as SB_RDONLY instead of failing it completely to preserve data recovery.

v3:
  - Moved validation logic inline into hfs_btree_open() to allow
    reporting the specific corrupted tree ID.
  - Replaced custom offset calculations with existing hfs_bnode_find()
    and hfs_brec_lenoff() infrastructure to handle node sizes and
    page boundaries correctly.
  - Removed temporary 'btree_bitmap_corrupted' superblock flag; setup
    SB_RDONLY directly upon detection.
  - Moved logging to hfs_btree_open() to include the specific tree ID in
    the warning message
  - Used explicit bitwise check (&) instead of test_bit() to ensure
    portability. test_bit() bit-numbering is architecture-dependent
    (e.g., bit 0 vs bit 7 can swap meanings on BE vs LE), whereas
    masking 0x80 consistently targets the MSB required by the HFS+
    on-disk format.

v2:
  - Fix compiler warning about comparing u16 bitmap_off with PAGE_SIZE which
can exceed u16 maximum on some architectures
  - Cast bitmap_off to unsigned int for the PAGE_SIZE comparison to avoid
tautological constant-out-of-range comparison warning.
  - Link: https://lore.kernel.org/oe-kbuild-all/202601251011.kJUhBF3P-lkp@intel.com/

Shardul Bankar (2):
  hfsplus: refactor b-tree map page access and add node-type validation
  hfsplus: validate b-tree node 0 bitmap at mount time

 fs/hfsplus/btree.c         | 236 +++++++++++++++++++++++++++++--------
 include/linux/hfs_common.h |   2 +
 2 files changed, 191 insertions(+), 47 deletions(-)

-- 
2.34.1

