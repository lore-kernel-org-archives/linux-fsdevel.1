Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792712187;
	b=Cu7M3LPLL03oLe0Up9fk1bp8qQyEWYbxdW8KOf09RrAifNyJDik+/OVXwAsWnSISaqkJ
	 AYhfLnvOjGnEgdBphX6RtKZINshWzdZoBAQlXT0nqSCmqLORm23si7BPFdXhxi2QxlhlC
	 nXfrSEgINNsIy3GRoozVpV5TtQ3oXrjthjH24D8X+J3qa8mihRIPrQ5k90qX8ZpAH94B8
	 kw1b6aRZVT2U9KaPoyY7taIP0lC/LaSwYy5TyjO71pdDH4rg09uButCfojlgt4c6qquOP
	 J+z61bgkNjYY1ZT2+ZVXiyaWUAy2ZLZhR8+ddaXnO7jh5C779LLzjBx6ZFQDfSanVmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792712187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nvdfVuToSAZdod65xO+90U5ZDL3fvzNu7MzlLs0W0tM=;
	b=PzI45grIM/KQ8ouft6N6MK6/p1Cn5evOQHOysU5DnO2UyegyVtH/SUYYBK0nFqN8LWwD
	 m1DKDKOQUi1V0iaqIZsJwQGIsbt5U5VRhNvLFf6fopKKcc8BpB8roie59Z/2MygoR7+E+
	 xZKQ79Rq5qpNO357SpnobPj1r57Fsvnplwdy5N63OppRvjTDWHLWk43px78x04R0Y+SFu
	 4PxXjCkABVm7Ov1F0qzq9RBEUveTtnDHnwsuHLD+oVJrVfYLqzm9m/+xHODJqUwZ1UHxr
	 BPeFe+b585CL0o/SQRLquVtfF+/OTJNKuzL0+4YV7nHdQw4WgVQAYk7MaB2FHQ+lcog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=DkZw7K6S;
	arc=none smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17936606A768
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 23:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17936606A768
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=DkZw7K6S
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6798eb0d13fso513336d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792712186; x=1793316986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nvdfVuToSAZdod65xO+90U5ZDL3fvzNu7MzlLs0W0tM=;
        b=DkZw7K6STYpK6hhebddOkVHapUhiblEMbumQZ47zkiyi1+yZ1C6GuilD/IeC5ObHC5
         c2r+bf8ARLQMqGpVTjbx8RaQbdp3r1Y/g/dxJOLoTp3yE5+4wNk0ewjA75n6AxVqBQCx
         zg0DmM9ALGmwO6NPXvwMXP5eVqtI35MLojF+Zr/7POXv0OkVxYZQw9vpNuUYT6qGt9g0
         yY+/NEHUusQhMDg9lbycnExzk1xKUTu92qfCw7U8KTAkqOshyYrrVSD91hkb1LeLQkBJ
         ZSJ8BUo6MRsemkgL5V3MV1lg2xwtmVR2vmbIeYvNRGBUabtjtJWOtSjJIqFxtZrISBQb
         uvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792712186; x=1793316986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nvdfVuToSAZdod65xO+90U5ZDL3fvzNu7MzlLs0W0tM=;
        b=Dsh7x23iKtoefhGLDjm/9dHur969OCVO0qrTHgEb6g151zWfOe8qaQn12WlSkyRQ14
         gzDc/Sct+ojgNCcof8i8+0my+Jl8G9BaXv/GRbBBl4xgV0FK93EgsKvhl2BtrAUnBpEC
         UjQOVddTQvcVRLsfrgobyk48RdUo0terMBkcOpUqgE1LhQH4/EH7FhQqOEW/Kz6vc5GG
         umggAwfs1CLDuwtd+pvp9YA+9edOF7LBqS0Y2RfACwsRlN/qKJFcTdrWOhTZGPx7qbj7
         eoUvQcM5SgyH8Lbux1jZXxVDAqXNpDk/MHg+GvPZQw217iTwPvCzhmEhGcCzskdmoS5Q
         OwmQ==
X-Gm-Message-State: AFq9FYLECkWMNHEvzf68B0mZnh5v8LuitC8z/ffFmdnJdq3YM3YJzTrE
	h14YRqznAsY644+lotzFzM49N6WHuKwhv9C/dccfG9TBzm9nvQrGhk/Qu62UaproKktqWYMdll5
	wsFq4RcE=
X-Gm-Gg: AYBFou2QQukqBL0tIJ+ceqRfvCpYftLrFilu3SVvgp4lnfYEe7MWrOjHWBHGaWS+UTQ
	0pD7RbedsUISdJsVwj6IZsrTzzxNbLn/GKzoi1i5TZVIbWb061faCLJWzjZJh91onpZTt0WZYWL
	qYhAADWtX+k6AXdsweNmbY4DcwNmSthxBunnN4i9kQEn7T3gko5GbismMIhE8F435nc67yDhtPc
	C03+LnXxT86x6AQQGTIvqkBEskw24+6fAFW4DJKqyVjQbaa6tV0KIUJQZjgJ/xWc85J7htV+CMG
	/wgOdAW0soi911Ex/gWyggPiHhBrE/O1eEVu5R0q5QgSWNAFt4yQJpfFfvEixqOsX7aAcwDcqkf
	vh4REN1yTgThahUC7rum8auhybVx7kgB1yFiXDqpMZBZRZMwkWuMUgfmQM2E5+sDyohI144YAiU
	DZ0L7lCJ/Mhh/mkwnEY1G/0571mAKVL/FFyhOlsPGJd/j2y761A/I6NbteeesyRmdmYo8XfkpDn
	CXwNA9sYPYY5D9iRs33Izra7eODsI/gweSda+C7Yy0AwKWNz0cUipPSjHQ0JwHalN++aoQB7ZgZ
	e0Fo7B3SwoDAEpKwRGaDJD1X+RmyARY0RKnh2f+NJhzTjuOVei1U7KJwYaoTIGrM8UWo5DJGXGT
	VkgGaFqdtug==
X-Received: by 2002:a05:690e:1201:b0:679:b810:6e03 with SMTP id 956f58d0204a3-67a35b10232mr333790d50.27.1792712185919;
        Thu, 22 Oct 2026 16:36:25 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:5551:17ca:f374:dc57])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a34009247sm487643d50.11.2026.10.22.16.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 16:36:25 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] hfs: fix orphaned b-tree node in hfs_bnode_split()
Date: Thu, 22 Oct 2026 16:35:47 -0700
Message-ID: <20261022233548.3481882-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022233548.3481882-1-slava@dubeyko.com>
References: <20261022233548.3481882-1-slava@dubeyko.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The xfstests' test-case generic/013 finishes with
corrupted HFS volume:

generic/013 27s ... [failed, exit status 1]_check_generic_filesystem: filesystem on /dev/loop50 is inconsistent

** Checking HFS volume.
   The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
   Invalid B-tree header
   Invalid map node
(4, 0)
** Checking catalog hierarchy.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was found corrupt and needs to be repaired.

The fsck tool detected that Catalog b-tree is corrupted.
Namely, the header node's counters and map node bitmap
have inconsistent state with the real b-tree structure.
The same issue has been fixed for the case of HFS+
by commit c1307d18caa8 ("hfsplus: fix generic/642 failure").

The hfs_bnode_split() contains a loop that implements
a roughly 50/50 split of the B-tree node's records by scanning
the offset table to find where the data crosses the node's midpoint.
If this logic detects the incapability of splitting the node, then
it simply calls hfs_bnode_put() for newly created node. However,
node is not set as HFS_BNODE_DELETED and real deletion of node
doesn't happen. As a result, the empty node becomes orphaned but
it is still accounted as used. Finally, fsck tool detects this
inconsistency of HFS volume.

Add call of hfs_bnode_unlink() before hfs_bnode_put()
for the case if new node cannot be used for splitting the existing
node.

HFS port of the HFS+ commit:
commit c1307d18caa8 ("hfsplus: fix generic/642 failure").

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/brec.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 5a2f740ddefd..1ca1ee9f73ef 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -254,6 +254,9 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 	struct hfs_bnode_desc node_desc;
 	int num_recs, new_rec_off, new_off, old_rec_off;
 	int data_start, data_end, size;
+	size_t rec_off_tbl_size;
+	size_t node_desc_size = sizeof(struct hfs_bnode_desc);
+	size_t rec_size = sizeof(__be16);
 
 	tree = fd->tree;
 	node = fd->bnode;
@@ -280,18 +283,22 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
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
@@ -302,7 +309,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		/* new record is in the lower half,
 		 * so leave some more space there
 		 */
-		old_rec_off += 2;
+		old_rec_off += rec_size;
 		num_recs--;
 		data_start = hfs_bnode_read_u16(node, old_rec_off);
 	} else {
@@ -310,27 +317,28 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
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

