Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417F346A0A
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 23:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257585; cv=none; b=gGMkuRXxbvSuctPqyp3w4JmUUbe1RwMNRj0LNVtR6Uswc34l5f3H3KaeUGw16tEaTNdooze4TTvJXWDONxK5UDUCdHxApG9TmPYnw/s4yVDFETcLuWaXQSUg8hwL/OBmVhqqLow3hIEh2WYDS64jE6EeLqsg597/QdcyfBR/yq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257585; c=relaxed/simple;
	bh=9DHhytlmFZPbA5rA/nWX/whX5kivJ7E9zpxZbHMXH64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9nfmer9wTYEo72/wmOLFXMJsunofEK628HsJkcu9X4/jTGx7Tn34prfurBA9rrx7h0wt7Zwl92opWNql4LqNIH8lpItEiDw7tcM2e7YsL2C1WlhLLjXHr9fv9ke8GxpjWtsnoxdlwKYfXk4yq7ogj9CQxQraVpJxvIymL9Q0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=vzTqH9CQ; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="vzTqH9CQ"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d4be94eeacso2218172a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 16:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775257583; x=1775862383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9PPh0maDXLsC7m+WkQICUb8JhfAda218dDBMCng+Ps=;
        b=vzTqH9CQbRGmbzwC+qp972Lpwc3UbGbB3dZ9eRmV10+tX44PGKT24guRWLB0ziLuNt
         zvZy2fJBAeqOvAGcuZC2AZ9XkKGhcZEH6UC5C8keVlkkw0tjTl9Gs0lUNMd8N79LfBrf
         h8tITQsX7QZ2zhjZeio+P9xYvvhD2FkaAnRgskunzD7TmbdtIgQWkT50XeIRjWgQe709
         aVNpPXOFhaOgTYlbV6a2E7zbtzhrKW8aaCnkzAbbGfp56TCafpPFgKEnaDCq+cn3MqjL
         yQ6sMPM7OOUP3CjNr7KFPwys9um9YgA2pBMfkVBTcOjD5Gdp7fZPQqmnf5UOKxnib2NR
         OBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257583; x=1775862383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9PPh0maDXLsC7m+WkQICUb8JhfAda218dDBMCng+Ps=;
        b=Ia2QdhZ1DNm84IGb9iezeD9LoK/bWdNxMWuq78ZLh+gCgrF3TyzSoaJWYN+XQKz6kP
         x9GECIgCMhZB1erd+xakdw6FPIZSDjFCbdauIIcDzssTV+SRm/czQvOR/95GLMg9TKF9
         UfrcBqfFGSOmUtNs9tCEroYsH0gzZcH6zRPJMARkPi2cdfakKPhGaNDlmKAD5Z+g5Sid
         hcfkdmN+5xf7ReUYM7eceJ+2640XtJAkMw5RxzY7UV0WusAiOBi+E1Dea4enh/OIRErw
         R1F60ymIqgToG+WlxeOweppjoKel91NTw1MKrsEYOxUSxOZDUEQTE46VdLqSUYyvLm9O
         bf6g==
X-Forwarded-Encrypted: i=1; AJvYcCVFq92cJHO2yr96hcLOGXRUgb17aVpduNI0D3SPA1NIuDWdCd+fohJC3iatoZodEmmrn6aNPo5XVPfwPl0k@vger.kernel.org
X-Gm-Message-State: AOJu0YyrXP+DpW71Lo3h5Gsrzjz0q06A4W8tbmZjHex3efVNzOBk4Sj9
	3xJghSEJbP+sVQ25x+IS5sAyYpdYehqchQo6i0x8Omzm7afVdtmL5z3e7iRNIL3rElQ=
X-Gm-Gg: ATEYQzxWOGDqfltsTw2PV4Ix3bQ3ckQ9kl1DJQlzJarpWGR0FX39eCy/zX0R/ERtdno
	qqM8xMn6+CHJKfFNvx8SY1gHOg5spWpEhbHM/3sfI6oDUyhwNm5ir+pCggdU31wUz75xl5XNQJ1
	DOA8pZvhbAKHSzZAP+3WAo6eM3XzmH2FJm2VRlqO0MYKgrbQDH1ldqXAXAYYVb8FzcqlzQ0D4ii
	GI+7A3glZ8ge8I2iZNaZfirtx4ybqcPROVYI0fcD9AQ6grIQV9BxMDvnpM/0SWdLX77GUIamxmD
	EVp6/Wc2sKRzTjMwMWbPBaKyNLGD1aHeTjKy2oXkONUUWrFgvTLlXRV4f2eLAiwYQ8C98qCyY1g
	xc2h71pRlMcVr+/a++14bXE8Pt/InV1LnGUbz4rvfqKEVDIIuN2E3HKbH6Hg5SjsahcyL939pAv
	EagwbrNgdSk/B51AO6vbIG25PPPsDB5AplBqEq50jTMwQ5iODn7OR9OmFsuel1yHxBmopiXcf88
	cVnHBpdpziqqSaMJSKJ93PT
X-Received: by 2002:a05:6830:67e3:b0:7db:a832:b329 with SMTP id 46e09a7af769-7dbb74e94aamr2758246a34.21.1775257582649;
        Fri, 03 Apr 2026 16:06:22 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:92cd:838f:83ea:d7f2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba7183dfesm5523210a34.9.2026.04.03.16.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:06:22 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 5/5] hfsplus: fix generic/642 failure
Date: Fri,  3 Apr 2026 16:05:56 -0700
Message-ID: <20260403230556.614171-6-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403230556.614171-1-slava@dubeyko.com>
References: <20260403230556.614171-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/642 finishes with
corrupted HFS+ volume:

sudo ./check generic/642
[sudo] password for slavad:
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 7.0.0-rc1+ #26 SMP PREEMPT_DYNAMIC Mon Mar 23 17:24:32 PDT 2026
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/642 6s ... _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see xfstests-dev/results//generic/642.full for details)

Ran: generic/642
Failures: generic/642
Failed 1 of 1 tests

sudo fsck.hfs -d /dev/loop51
** /dev/loop51
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
invalid free nodes - calculated 1637 header 1260
Invalid B-tree header
Invalid map node
(8, 0)
** Checking volume bitmap.
** Checking volume information.
Verify Status: VIStat = 0x0000, ABTStat = 0xc000 EBTStat = 0x0000
CBTStat = 0x0000 CatStat = 0x00000000
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.

The fsck tool detected that Extended Attributes b-tree is corrupted.
Namely, the free nodes number is incorrect and map node
bitmap has inconsistent state. Analysis has shown that during
b-tree closing there are still some lost b-tree's nodes in
the hash out of b-tree structure. But this orphaned b-tree nodes
are still accounted as used in map node bitmap:

tree_cnid 8, nidx 0, node_count 1408, free_nodes 1403
tree_cnid 8, nidx 1, node_count 1408, free_nodes 1403
tree_cnid 8, nidx 3, node_count 1408, free_nodes 1403
tree_cnid 8, nidx 54, node_count 1408, free_nodes 1403
tree_cnid 8, nidx 67, node_count 1408, free_nodes 1403
tree_cnid 8, nidx 0, prev 0, next 0, parent 0, num_recs 3, type 0x1, height 0
tree_cnid 8, nidx 1, prev 0, next 0, parent 3, num_recs 1, type 0xff, height 1
tree_cnid 8, nidx 3, prev 0, next 0, parent 0, num_recs 1, type 0x0, height 2
tree_cnid 8, nidx 54, prev 29, next 46, parent 3, num_recs 0, type 0xff, height 1
tree_cnid 8, nidx 67, prev 8, next 14, parent 3, num_recs 0, type 0xff, height 1

This issue happens in hfs_bnode_split() logic during detection
the possibility of moving half ot the records out of the node.
The hfs_bnode_split() contains a loop that implements
a roughly 50/50 split of the B-tree node's records by scanning
the offset table to find where the data crosses the node's midpoint.
If this logic detects the incapability of spliting the node, then
it simply calls hfs_bnode_put() for newly created node. However,
node is not set as HFS_BNODE_DELETED and real deletion of node
doesn't happen. As a result, the empty node becomes orphaned but
it is still accounted as used. Finally, fsck tool detects this
inconsistency of HFS+ volume.

This patch adds call of hfs_bnode_unlink() before hfs_bnode_put()
for the case if new node cannot be used for spliting the existing
node.

sudo ./check generic/642
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 7.0.0-rc1+ #26 SMP PREEMPT_DYNAMIC Fri Apr  3 12:39:13 PDT 2026
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/642 40s ...  39s
Ran: generic/642
Passed all 1 tests

Closes: https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/242
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/brec.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 6796c1a80e99..e3df89284079 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -239,6 +239,9 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 	struct hfs_bnode_desc node_desc;
 	int num_recs, new_rec_off, new_off, old_rec_off;
 	int data_start, data_end, size;
+	size_t rec_off_tbl_size;
+	size_t node_desc_size = sizeof(struct hfs_bnode_desc);
+	size_t rec_size = sizeof(__be16);
 
 	tree = fd->tree;
 	node = fd->bnode;
@@ -265,18 +268,22 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		return next_node;
 	}
 
-	size = tree->node_size / 2 - node->num_recs * 2 - 14;
-	old_rec_off = tree->node_size - 4;
+	rec_off_tbl_size = node->num_recs * rec_size;
+	size = tree->node_size / 2;
+	size -= node_desc_size;
+	size -= rec_off_tbl_size;
+	old_rec_off = tree->node_size - (2 * rec_size);
+
 	num_recs = 1;
 	for (;;) {
 		data_start = hfs_bnode_read_u16(node, old_rec_off);
 		if (data_start > size)
 			break;
-		old_rec_off -= 2;
+		old_rec_off -= rec_size;
 		if (++num_recs < node->num_recs)
 			continue;
-		/* panic? */
 		hfs_bnode_put(node);
+		hfs_bnode_unlink(new_node);
 		hfs_bnode_put(new_node);
 		if (next_node)
 			hfs_bnode_put(next_node);
@@ -287,7 +294,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		/* new record is in the lower half,
 		 * so leave some more space there
 		 */
-		old_rec_off += 2;
+		old_rec_off += rec_size;
 		num_recs--;
 		data_start = hfs_bnode_read_u16(node, old_rec_off);
 	} else {
@@ -295,27 +302,28 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		hfs_bnode_get(new_node);
 		fd->bnode = new_node;
 		fd->record -= num_recs;
-		fd->keyoffset -= data_start - 14;
-		fd->entryoffset -= data_start - 14;
+		fd->keyoffset -= data_start - node_desc_size;
+		fd->entryoffset -= data_start - node_desc_size;
 	}
 	new_node->num_recs = node->num_recs - num_recs;
 	node->num_recs = num_recs;
 
-	new_rec_off = tree->node_size - 2;
-	new_off = 14;
+	new_rec_off = tree->node_size - rec_size;
+	new_off = node_desc_size;
 	size = data_start - new_off;
 	num_recs = new_node->num_recs;
 	data_end = data_start;
 	while (num_recs) {
 		hfs_bnode_write_u16(new_node, new_rec_off, new_off);
-		old_rec_off -= 2;
-		new_rec_off -= 2;
+		old_rec_off -= rec_size;
+		new_rec_off -= rec_size;
 		data_end = hfs_bnode_read_u16(node, old_rec_off);
 		new_off = data_end - size;
 		num_recs--;
 	}
 	hfs_bnode_write_u16(new_node, new_rec_off, new_off);
-	hfs_bnode_copy(new_node, 14, node, data_start, data_end - data_start);
+	hfs_bnode_copy(new_node, node_desc_size,
+			node, data_start, data_end - data_start);
 
 	/* update new bnode header */
 	node_desc.next = cpu_to_be32(new_node->next);
-- 
2.43.0

