Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795797174;
	b=NL3xyfdBzvv/PGrmzLxSQ25cUkOAGai8nojAL4RxwMLgpXXLStgZtXh3WOLaz+gHTJnb
	 fnjUU6J1QUHTIdspFxF6WvAGhngAaZe3xFQBB0jDP6caTSO1AKpAPNoPi2a+QkS6BN+lf
	 SpZBVjSeJhskerRU8MfOxTBYyKIrsebLhqZDVxaRJW7mmP3RMvoKu0PqSwLuaEaPxMaQo
	 e1nsipgCbV4w0zp47XdBKCLtR4sns2T4A2P0sh/vvApCEReB+kIgnmgNoxQLXkPfsBAmZ
	 K/CurgiXeKi9vNWgSgMZlAJm3bv/FERHODz1gwbLgwRwALvjZrJt18U34BTdHi8QZUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Mailer:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=BzVKtW5NHdb/sxlNHYFUIiHG+65dbsYhejickBFJVMk=;
	b=weAnExVXEZ1fz6iIo5XoqvnslYuBQiNFfEpNtUuAtDgaO1kNYkQgLZL+5UzR2xTuI++W
	 Bl1Tcr/8hlcwhFFB3dqH5up60FvC9SwbRur2d6hXak2NLPZEHFPdts/fA/IYgFYDq2uWL
	 zyWhK3yJ+0cA7gx5HPm54LK2ff40ZhnftUZoSjWE1V/RaGRP/sxcLvyc+dAxq70nW1R32
	 CZEY80Vx4T6QvIyZYHrQyMwdQSgose+YQC7hKFdUG6jSoziAEjWWj5qlLCWgAAVowIg1A
	 6ZblrwQWlaykwbw1l80C/DRRPgiydKFxWGBLw5AGg/MW0Mfa4Y2wgFSjIKv2CsCzxsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=echophase.com;
	spf=pass smtp.mailfrom=echophase.com;
	dkim=pass header.d=echophase.com header.i=@echophase.com header.a=rsa-sha256 header.s=google header.b=nU7VRCMg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3D2606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 16:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC3D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=echophase.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=echophase.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=echophase.com header.i=@echophase.com header.a=rsa-sha256 header.s=google header.b=nU7VRCMg
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67db89857abso8649294d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 08:32:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795797173; cv=none;
        d=google.com; s=arc-20260327;
        b=fJtqtXDJ2Jbpk89EPPtNhujUPU/jwUU5Qu9jWkbz9f9oR24cLLR2yQc6YoZgkutRnt
         VAmwRhTpzZUfb8Afv9ciYSaii0sjZTLcSOwoJehF4jIcDt/DKcxpiCTqVcHq1SS2M23d
         4ZOpKjbEsJaLMWm/s4LBZuhNV7RWnt8es45eyyDH5+gE9w++0iHP18Lu76yzAY3sePbT
         Y6G8HTb3Z1tlQTutfA028gWf4RpXzhe9F7nPH8lPXmVq4ES1MeHiIc4pMxe4X7jXDob8
         twJf+oYtkFM8fbrgVW09/wMBwQ8ou8YKs/1D/g6xzHTHbctRJpC8Af4PFn5B7qgZmDeE
         xAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=BzVKtW5NHdb/sxlNHYFUIiHG+65dbsYhejickBFJVMk=;
        fh=QT+a7LpyZlOGumZSHWf9im4iy2+p/v3VFGhj/7GOWiM=;
        b=G4pcP4zBYfKRkucqo8NrW5q3MOndLKu2/VDjGXo2W1i4o5Tpr4p5jmJ0/2g0lw3jiT
         MwfU2dQIW5NcY9H5aY5JVL78iB4xJBsoFBFl7fpOH3M2cg/lTuo2fKP2q/OfiReAuQoi
         a2c4wVbDRpkKIF85yGTVzWggvvqkPYdNXPaDDP308jhwsTngdSXdZZrKrWijBGlCfwbj
         xmjB4jHcYB0YuIns0rFJfW7SX2dimwOCciwmMskr4KcXHQEMNm+I7NOMQminvqgK3xrX
         zODEqPZzyEa5cCU3Sw+rhLGNtOUNW4jDriSyIpSNlW2ysMOtzJz2onj56nJnbKINEAU3
         KIRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=echophase.com; s=google; t=1795797173; x=1796401973; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BzVKtW5NHdb/sxlNHYFUIiHG+65dbsYhejickBFJVMk=;
        b=nU7VRCMg6S/PeSbcDbddxdWo5UV71g1l2fPnpOLkBeJHmI9vd/VtSayPDD4kRpRLyL
         n30mU1diRB602R5GjrBWEK11PMzWVwFPDFMdbfX3zOVnhtYiJhipK271461Ahnt7Yu2j
         EBBIpeZK7iLzsCFsZHOZlYSjWk0KxQurIsoodiKn0DPM9Rb4dMKDzmAZgiyzStC8x9Jl
         Pjn8YwTY8PxnTUoiD6d0Mr8jKHAg+Ht5fddR715CorMfa7728u5pwAqNMOIF6baQVaSl
         2tzK1TW/qAVbfSOPjzZlRV6Cf66oqXNcO0DyT1D9Y1IsW77fm9WP6bqRC+Nc6zBybrXO
         p7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795797173; x=1796401973;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BzVKtW5NHdb/sxlNHYFUIiHG+65dbsYhejickBFJVMk=;
        b=bvhedtKQ4Czyd9J4edsm8nLivBFj03R88EfImQAyLmaTpeE4CMHh2lM8vTqMZxN02y
         q9Vr8B3qazWB7ucsfOJwF2H0UrxPaEJU4NH7D0MIZgPRKnFDPzDxkh8GT2ARSPjsmJC/
         QUqnF6a7KNL0wrwgtucWyz/iS+UoQXPj6TGMFkSyv0J+tsQA+SJyrpmPUAw5DNiX1+mw
         nEDpXuMysiIzOOljrvhyE96FHjrteaff3YiucUUrkVHcN2KO9LeNfyKdBLVnI/pR9DPX
         6bpJiDTZUwwBu4/SNuaLO37tZfLLneIqOxbP7LetXXL/KMTSEDvlAXqh4GPLCSFt8+3x
         oSPg==
X-Forwarded-Encrypted: i=1; AL+hErGcugzGsvWLMds5lyUacf9qx13LkGhPGRaYerSChr7FXw6a6y3v5CvNwJnysku9mIu+ayR8HbMntOjdVwx3@vger.kernel.org
X-Gm-Message-State: APuU4Z+/BdHB9ZwC+9b6fw1m5319YRyYRjb+O1hr4fGc7i7tulsVhfkM
	h+UNWvsZ6Tb7OJioEK5KeuRlKssH1Jr7Q1Z+mXilvqizF/g33Zsxe0n7qnZo4xUTm3L+31G3x2e
	tsarfgUyavA6uVyVZARmQMNlldcwj0Hb/MN4ywEaDcg==
X-Gm-Gg: AZFdTZdy/oEJEZ250EjsoNRRRavyio58GLTDK8cuy1fzeCWdQM7ffR7NxmV905cqlrz
	RUon5HVutKcb6RBjMT/VOA5XI2+Zx4iu62bpJSIwMvtJWW/ZzpMSD44yge5VDScISbFP+assNjP
	mcDENfE4wtFupkI65oAISQO0HpMhdQb19DAkRG2lHKVonBb7XSafLCI2MY6QF1MY2ZAIDTORTRn
	AHssIKaQXhiWxALjpxSuyRRBFOGVoHGiT4h/E9CmERobPuAldwn0ndwq8qy5W/gmjLipqaRXEr6
	UnXYV+gbr8RtACoQGp5zeFVVJshycnIvxRbfs/frvV3B33hZ7QOxQJYuoVKB/PCXIZHwiI7Tuqk
	0tnR3XUYCgoTIWWiPG9xABFKsS4thTzJvr+hE78UqgGci9HIekvlDqv1pAdTW0r1vge2sOQ==
X-Received: by 2002:a05:690e:47c7:20b0:679:ad63:6752 with SMTP id
 956f58d0204a3-67df4485df0mr6760668d50.88.1795797172525; Fri, 27 Nov 2026
 08:32:52 -0800 (PST)
Received: from 1009040482268 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 27 Nov 2026 08:32:51 -0800
From: Ramon Nogueira <ramon@echophase.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 27 Nov 2026 08:32:51 -0800
X-Gm-Features: Aa3M54rMQUzpO4yRAeN4raM6katXNjxW27MCpyzDDVBLsa2OU0HqYrWxnLZTdwk
Message-ID: <CAMM96J2Ma3gSwZAtF2S2XNWxP4wBtN5VxYRY_KQO3fqNGztrEA@mail.gmail.com>
Subject: [PATCH] fs/dax: do not replace existing shared DAX entry on read faults
To: Dan Williams <djbw@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Shiyang Ruan <ruansy.fnst@fujitsu.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Ramon Nogueira <ramon@echophase.com>
Content-Type: text/plain; charset="UTF-8"

Commit c6f0b395b211 ("fsdax,xfs: set the shared flag when file extent is
shared") replaced the write-only cow check in dax_insert_entry() with
shared = iter->iomap.flags & IOMAP_F_SHARED so that
dax_associate_entry() receives shared=true on read faults of shared
extents as well as CoW write faults.

However, unmap_mapping_pages() and XArray entry replacement were also
switched from cow to shared. As a result, whenever a filesystem sets
IOMAP_F_SHARED on DAX read faults (such as XFS on reflinked extents via
xfs_read_iomap_begin()), every read fault on an already-populated entry
zaps all mappings of this file for that range and replaces the XArray
entry with an identical one.

Two processes (or distinct VMAs) reading the same page of a reflinked
DAX file then ping-pong: each read fault unmaps the other VMA's PTE,
causing repeated page faults, XArray entry lock contention, and TLB
shootdowns. Furthermore, a PTE read fault hitting an existing shared PMD
entry unmaps and overwrites the PMD entry with a PTE-flagged entry.

Keep shared for dax_associate_entry(), and restore cow = write && shared
to gate unmap_mapping_pages(), entry replacement of existing real
entries, and PAGECACHE_TAG_TOWRITE. First read faults on empty or zero
entries still enter the insertion branch and pass shared=true to
dax_associate_entry(), while subsequent read faults leave the existing
PTE or PMD entry and other mappings intact.

Fixes: c6f0b395b211 ("fsdax,xfs: set the shared flag when file extent
is shared")
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Ramon Nogueira <ramon@echophase.com>
---
 fs/dax.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 9d161d7ef..de3931788 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1078,11 +1078,12 @@ static void *dax_insert_entry(struct xa_state
*xas, struct vm_fault *vmf,
 	bool write = iter->flags & IOMAP_WRITE;
 	bool dirty = write && !dax_fault_is_synchronous(iter, vmf->vma);
 	bool shared = iter->iomap.flags & IOMAP_F_SHARED;
+	bool cow = write && shared;

 	if (dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);

-	if (shared || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
+	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
 		unsigned long index = xas->xa_index;
 		/* we are replacing a zero page with block mapping */
 		if (dax_is_pmd_entry(entry))
@@ -1094,7 +1095,7 @@ static void *dax_insert_entry(struct xa_state
*xas, struct vm_fault *vmf,

 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;

 		dax_disassociate_entry(entry, mapping, false);
@@ -1102,12 +1103,13 @@ static void *dax_insert_entry(struct xa_state
*xas, struct vm_fault *vmf,
 					vmf->address, shared);

 		/*
-		 * Only swap our new entry into the page cache if the current
-		 * entry is a zero page or an empty entry.  If a normal PTE or
-		 * PMD entry is already in the cache, we leave it alone.  This
-		 * means that if we are trying to insert a PTE and the
-		 * existing entry is a PMD, we will just leave the PMD in the
-		 * tree and dirty it if necessary.
+		 * Only swap our new entry into the page cache on a CoW write
+		 * fault, or if the current entry is a zero page or an empty
+		 * entry.  If a normal PTE or PMD entry is already in the cache
+		 * on a read fault, we leave it alone.  This means that if we
+		 * are trying to insert a PTE and the existing entry is a PMD,
+		 * we will just leave the PMD in the tree and dirty it if
+		 * necessary.
 		 */
 		old = dax_lock_entry(xas, new_entry);
 		WARN_ON_ONCE(old != xa_mk_value(xa_to_value(entry) |
@@ -1120,7 +1122,7 @@ static void *dax_insert_entry(struct xa_state
*xas, struct vm_fault *vmf,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);

-	if (write && shared)
+	if (cow)
 		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);

 	xas_unlock_irq(xas);

base-commit: 9437ee8b6cf607e883b36e44bd755968daaebd48
-- 
2.54.0 (Apple Git-157)
