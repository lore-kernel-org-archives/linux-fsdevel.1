Received: from lgeamrelo13.lge.com (lgeamrelo13.lge.com [156.147.23.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADF3212FAD
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 23:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.23.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777851613; cv=none; b=QjNH58uLspcT3s/xdDVxSmWq3Ra4go5Uhga0q/2N/pLugq0X/lQCuhroiWqPPrRaUYjIMBh8wONScV/q5seeob7CVQKohGvP5h3GMWoIJAyPZzmw2jslQz/pdhN6mNGkbAPtm6BWhQaaxtbdtbf7IHf4smZZU9Va85M9Ql8VFPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777851613; c=relaxed/simple;
	bh=P6PXpoBNGb73jOx541F/PvF9xAacXZlHmG4Tx512h2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FIjdfHVKmWwbWENwNd4WVUqUsyaspdND0qkpZ8P9+F+pJzQTJXw55Pjql1di7r9WDmNTrgNggeQEo4jJd3Cizwl06Wi129A49QIZgjwCiT+D8d54j6sP1LR3XzWhoeD7ugEbFDYOMw/yWUmthgpuZ+8+Giit+y1aNP4CMme8cTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=156.147.23.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
	by 156.147.23.53 with ESMTP; 4 May 2026 08:30:10 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO hyunchul-PC02.lge.net) (10.177.111.62)
	by 156.147.1.151 with ESMTP; 4 May 2026 08:30:10 +0900
X-Original-SENDERIP: 10.177.111.62
X-Original-MAILFROM: hyc.lee@gmail.com
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cheol.lee@lge.com
Subject: [PATCH] ntfs: match ntfs_resident_attr_min_value_length with $AttrDef
Date: Mon,  4 May 2026 08:29:51 +0900
Message-ID: <20260503232951.3710803-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update ntfs_resident_attr_min_value_length() to align with $AttrDef.

The Windows 11 $AttrDef values are as follows:

Attribute Name             (ID)   Size (Min-Max)  Flags

$STANDARD_INFORMATION      (16)   48-72           Resident
$ATTRIBUTE_LIST            (32)   No Limit        Non-resident
$FILE_NAME                 (48)   68-578          Resident, Index
$OBJECT_ID                 (64)   0-256           Resident
$SECURITY_DESCRIPTOR       (80)   No Limit        Non-resident
$VOLUME_NAME               (96)   2-256           Resident
$VOLUME_INFORMATION        (112)  12-12           Resident
$DATA                      (128)  No Limit        (None)
$INDEX_ROOT                (144)  No Limit        Resident
$INDEX_ALLOCATION          (160)  No Limit        Non-resident
$BITMAP                    (176)  No Limit        Non-resident
$REPARSE_POINT             (192)  0-16384         Non-resident
$EA_INFORMATION            (208)  8-8             Resident
$EA                        (224)  0-65536         (None)
$LOGGED_UTILITY_STREAM     (256)  0-65536         Non-resident

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ntfs/attrib.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 78915c1d5128..4950fc2fa536 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -576,24 +576,15 @@ static u32 ntfs_resident_attr_min_value_length(const __le32 type)
 	case AT_STANDARD_INFORMATION:
 		return offsetof(struct standard_information, ver) +
 		       sizeof(((struct standard_information *)0)->ver.v1.reserved12);
-	case AT_ATTRIBUTE_LIST:
-		return offsetof(struct attr_list_entry, name);
 	case AT_FILE_NAME:
-		return offsetof(struct file_name_attr, file_name);
-	case AT_OBJECT_ID:
-		return sizeof(struct guid);
-	case AT_SECURITY_DESCRIPTOR:
-		return sizeof(struct security_descriptor_relative);
+		return offsetof(struct file_name_attr, file_name) +
+			sizeof(__le16) * 1;
+	case AT_VOLUME_NAME:
+		return sizeof(__le16) * 1;
 	case AT_VOLUME_INFORMATION:
 		return sizeof(struct volume_information);
-	case AT_INDEX_ROOT:
-		return sizeof(struct index_root);
-	case AT_REPARSE_POINT:
-		return offsetof(struct reparse_point, reparse_data);
 	case AT_EA_INFORMATION:
 		return sizeof(struct ea_information);
-	case AT_EA:
-		return offsetof(struct ea_attr, ea_name) + 1;
 	default:
 		return 0;
 	}
-- 
2.43.0

