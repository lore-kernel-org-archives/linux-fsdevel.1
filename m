Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC863BED5C;
	Thu, 23 Apr 2026 21:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776981021; cv=pass; b=subuTeom4Eo48jhoosWXcg9gYjx+ikRW6ekLuuGDz2ebjh2Wpf7GDgxT+aU7PE5c7iXq4HSP6rBemFx57wW76Q/Wg5UCt79TDhlyB13cww/NKFlQuEvBrvX8a/Sg/gmEm+85w0MCuVWQKcKWhtF7xkMJltv3LxQ33ZAcY2NaFE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776981021; c=relaxed/simple;
	bh=6bPqillUrQ9W/2OjJ6GN8GYLQMDYDK2i72yxcjdIorM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFHIMKu7gKyHjulSC1yrXhr0MjNS7UZzNQS9PrTAK/goRnfA+B9rGQbPaOaI0CNIoKAygbYrfMI6lJ4SBn1rcrGRXFnf15lK2n6BYAVOsNui3bGn2p6BcVvYl20PjFwaqE2KUBlGrFEHtA8muoFWd/1AKqH1A3vacNh3FEIfSJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=LNmpl++/; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="LNmpl++/"
ARC-Seal: i=1; a=rsa-sha256; t=1776980988; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QzSQBgkNjMcmiOiapYBWmlclZEoIjFihi9skefV42jtXPr/bSZABWwxl9Ca6RmJ2Mfk34/J/9UjK0Wr3tjNqy1s5lfhkIYcRzyHopBvWlpa/QyAyPkGPDiJQtjOpN5n84N5Y/ORH/DEARCUpcQzz+3uz7DplGWsjKhTwnb/C22U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776980988; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c6RLRqS5WEZhXQfn0WoraRjQTpbBGxxcZmLEbqXwqUY=; 
	b=RZlI60NbD5191ePiO3z0r6Qgl5qEV/E4z3MlIPOUfSLcjIK76DHx7xN29D73h0qqVxIvmzw149zR6W/C47fr8OifgmvTyaJY6QpxF/PPyy5hGyE4x9GbHDoHmIDkjxloKOx1ZEB12WEZAIPLF+gn913vw5O5Niw4C1kcWhJZGms=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776980988;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=c6RLRqS5WEZhXQfn0WoraRjQTpbBGxxcZmLEbqXwqUY=;
	b=LNmpl++//5+iF68MU+a5z6eWIPMrJngEcUYfEOxA39T/gfak1cnb487SFxQQG6ay
	QhVLxsGZOlKH03jkJKdo5AECp81GEGFiOTmF6Ph685s9bXy2BMtFinpPiUB9tmgpo12
	GcDZQTN3VlrksxS8THdcnU8xAT4MIinDAQ+/cnd4=
Received: by mx.zohomail.com with SMTPS id 17769809853267.480022099607481;
	Thu, 23 Apr 2026 14:49:45 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	janak@mpiric.us,
	kalpan.jani@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH] hfsplus: fix hfs_bnode_split() failure on sparsely-filled nodes
Date: Fri, 24 Apr 2026 03:19:36 +0530
Message-Id: <20260423214936.444718-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

hfs_bnode_split() determines the split point by scanning the node's
offset table for the first record whose data offset exceeds a threshold
derived from node_size / 2. When all record data fits within the first
half of the node, no record offset exceeds the threshold, the loop
exhausts all records, and the function returns -ENOSPC even though the
node can be validly split. This causes xattr insertions to fail
silently.

The failing code path is exercised by xfstests generic/070 and
generic/642 during xattr stress operations.

Fix this by re-scanning with a threshold based on the actual data
midpoint when the position-based scan exhausts. If the re-scan also
exhausts, fall back to splitting off the last record.

Reported-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/brec.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index e3df89284079..cfc909c808a4 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -282,12 +282,32 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		old_rec_off -= rec_size;
 		if (++num_recs < node->num_recs)
 			continue;
-		hfs_bnode_put(node);
-		hfs_bnode_unlink(new_node);
-		hfs_bnode_put(new_node);
-		if (next_node)
-			hfs_bnode_put(next_node);
-		return ERR_PTR(-ENOSPC);
+		/*
+		 * All data fits within the node_size/2 threshold,
+		 * so re-scan using the actual data midpoint.
+		 */
+		size = hfs_bnode_read_u16(node, tree->node_size -
+			(node->num_recs + 1) * rec_size);
+		size = ((int)node_desc_size + size) / 2;
+		old_rec_off = tree->node_size - (2 * rec_size);
+		num_recs = 1;
+		for (;;) {
+			data_start = hfs_bnode_read_u16(node,
+							old_rec_off);
+			if (data_start > size)
+				break;
+			old_rec_off -= rec_size;
+			if (++num_recs < node->num_recs)
+				continue;
+			/* last record holds most of the data */
+			num_recs = node->num_recs - 1;
+			old_rec_off = tree->node_size -
+				(num_recs + 1) * rec_size;
+			data_start = hfs_bnode_read_u16(node,
+							old_rec_off);
+			break;
+		}
+		break;
 	}
 
 	if (fd->record + 1 < num_recs) {
-- 
2.34.1

