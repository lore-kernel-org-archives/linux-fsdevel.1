Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0A478E20
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788253995; cv=none; b=t88CSVflFeRL23zj2WoQ3xjqCcuqSNxWNckwP7+sk5t/NDJl1fAnB/kyvVnjb7lbOvhc9aSPDVDYqY86Uces+LZg2y4B9zBJlAVUNjuZwB80pMuDpJdLednaujmHU0+pHPV2ygC8OYdzuRtEDjDiA85pwHkRIprzde0xP5KGasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788253995; c=relaxed/simple;
	bh=Kz5orfdJ+osMfQTyBN16UMrmkNDea/vPNdF3EOvKu7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YljNF6DG8DANCD8VZsE5/5kW3SuzDT3hDXA9TN+xFJ1wseXaxkOq7L6dNZHDtaFKXUBYgl9FcXPO0z2cD5EIWab6qGJ919G744Iu00EYbC+ZkUO1m5s0PVsVG8i7xeC6m6C1P+sFR3s6xeT/gHk6E3XbK04utyULaRwjUOsHz8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pNcXTLNP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7/fTnQAW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rk3LuYCe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3NpABllw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pNcXTLNP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7/fTnQAW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rk3LuYCe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3NpABllw"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B84841FDA1;
	Tue,  1 Sep 2026 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788253986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K20ozTdpZ8LCL0qJzkRtBKwVELUU+ifvZ7lzGG6Ug8k=;
	b=pNcXTLNPkHgOyFmxNpNp7ceQriwTWub4PXJU2x5+QdqABBw/hRcJ4SdcN/kT0DwSrthu0U
	RpAEBdyo7YGO8Mg6EMER8KQMPLtbH1IZcmdy/oJW4STw+efvUCS2lSgwnKuUACy55l6qpK
	Kaw26+G4be9/5NDifA72Mo917ekkLoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788253986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K20ozTdpZ8LCL0qJzkRtBKwVELUU+ifvZ7lzGG6Ug8k=;
	b=7/fTnQAWdREGoYK+1z3HVMZmV9eTe5sEiwOMXKxqtji4ATdXLqbrjd7T2MSgmQhAS6tGGL
	OAz9OpMsx4nqnKDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rk3LuYCe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3NpABllw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788253982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K20ozTdpZ8LCL0qJzkRtBKwVELUU+ifvZ7lzGG6Ug8k=;
	b=rk3LuYCeCJOez1tv1QEzRxoATnV6g0qXhfY2hvI6gbiFpzI+H+dM/RS6/X9a9EwX0ZDw9d
	RPto7/5TGTzmPGZv/69jPeMJdsMFooftDKdh+zaGwDi/R2SP0Y41zRMnSJXjeveQ0JzuTT
	HR+V5J0ax0Wpx9JDLd4rMVAgh0aVXfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788253982;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K20ozTdpZ8LCL0qJzkRtBKwVELUU+ifvZ7lzGG6Ug8k=;
	b=3NpABllw65BDww2gkUdNttcpvFy3nn8KN/uHRLE3qwCQbcGd2WCI4lLl62MBEj1xJ1u+lv
	XjVdCkpYAxRKG2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6ECEC136B2;
	Tue,  1 Sep 2026 09:13:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oroMGx6XlmrKMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 01 Sep 2026 09:13:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D84F1A13B8; Tue, 01 Sep 2026 11:13:01 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] udf: Avoid confusion of missing and corrupted extended attributes
Date: Tue,  1 Sep 2026 11:12:26 +0200
Message-ID: <20260901091256.1226297-4-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260901091037.30587-1-jack@suse.cz>
References: <20260901091037.30587-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4358; i=jack@suse.cz; h=from:subject; bh=Kz5orfdJ+osMfQTyBN16UMrmkNDea/vPNdF3EOvKu7Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqlpcZF+w8kuwm/RgxeKBwhFi+NjNZefjFqQ7m7 SJZ/vTwg7mJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCapaXGQAKCRCcnaoHP2RA 2eTYB/93wRIKLMu2WQO+JrMD3Hr4yU/R0MyE8Iqs44fkYdWFfsC1a3+XG5PyWdzJ36jTOWu4Dz8 GdIQjiPPaX4UiiqCy0oYBCWu3l8E/UcvgoyyeiYxuE/IsjIZEumB58CovlDvdbNWwg13RG++0Lm U85OZ8hQAHLIOm60eCUMtZqIi0nSodXNGqD1J1+Cb5b/JFZn61uqgu0Tp95T8iAH28ss6HZE7d4 w7xQaHoHtvfNqDTjO0A9TUFJsqi8U0uo5gGyK2vmejXHQ2TfVSEp+66m5m+ieqkUiN/33h4HARi h1KmXX/2jWMtmQvNw4vrnEsIOswMlKMMx7I0VmOLFtTNGpKR
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B84841FDA1
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -3.01

udf_get_extendedattr() returns NULL either when extended attribute was
not found or when some corrupted attribute was found. Similarly
udf_add_extendedattr() returns NULL when extended attributes are
corrupted or when there's no space to insert the extended attribute.
Make both functions return proper error codes to discern these cases and
handle them in the callers.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/inode.c | 23 ++++++++++++++++-------
 fs/udf/misc.c  | 15 ++++++++-------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index baf9845ac06b..8babc2fbce9a 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1675,8 +1675,15 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		struct deviceSpec *dsea =
 			(struct deviceSpec *)udf_get_extendedattr(inode, 12, 1);
 
-		if (!dsea || !udf_device_spec_valid(dsea))
+		if (IS_ERR(dsea)) {
+			ret = PTR_ERR(dsea);
 			goto out;
+		}
+		/* Device inodes must have a device spec attribute */
+		if (!dsea || !udf_device_spec_valid(dsea)) {
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
 		init_special_inode(inode, inode->i_mode,
 				MKDEV(le32_to_cpu(dsea->majorDeviceIdent),
 				      le32_to_cpu(dsea->minorDeviceIdent)));
@@ -1836,13 +1843,19 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 		struct regid *eid;
 		struct deviceSpec *dsea =
 			(struct deviceSpec *)udf_get_extendedattr(inode, 12, 1);
+
+		/* Validity of extended attrs was checked on load */
+		if (WARN_ON_ONCE(IS_ERR(dsea))) {
+			err = PTR_ERR(dsea);
+			goto out_unlock;
+		}
 		if (!dsea) {
 			dsea = (struct deviceSpec *)
 				udf_add_extendedattr(inode,
 						     sizeof(struct deviceSpec) +
 						     sizeof(struct regid), 12, 0x3);
-			if (!dsea) {
-				err = -ENOSPC;
+			if (IS_ERR(dsea)) {
+				err = PTR_ERR(dsea);
 				goto out_unlock;
 			}
 			dsea->attrType = cpu_to_le32(12);
@@ -1852,10 +1865,6 @@ int udf_write_inode(struct inode *inode, struct writeback_control *wbc)
 						sizeof(struct regid));
 			dsea->impUseLength = cpu_to_le32(sizeof(struct regid));
 		}
-		if (!udf_device_spec_valid(dsea)) {
-			err = -EFSCORRUPTED;
-			goto out_unlock;
-		}
 		eid = (struct regid *)dsea->impUse;
 		memset(eid, 0, sizeof(*eid));
 		strcpy(eid->ident, UDF_ID_DEVELOPER);
diff --git a/fs/udf/misc.c b/fs/udf/misc.c
index 6928e378fbbd..a2084dfbfbd6 100644
--- a/fs/udf/misc.c
+++ b/fs/udf/misc.c
@@ -58,7 +58,7 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
 					cpu_to_le16(TAG_IDENT_EAHD) ||
 			    le32_to_cpu(eahd->descTag.tagLocation) !=
 					iinfo->i_location.logicalBlockNum)
-				return NULL;
+				return ERR_PTR(-EFSCORRUPTED);
 		} else {
 			struct udf_sb_info *sbi = UDF_SB(inode->i_sb);
 
@@ -122,7 +122,7 @@ struct genericFormat *udf_add_extendedattr(struct inode *inode, uint32_t size,
 		return (struct genericFormat *)&ea[offset];
 	}
 
-	return NULL;
+	return ERR_PTR(-ENOSPC);
 }
 
 struct genericFormat *udf_get_extendedattr(struct inode *inode, uint32_t type,
@@ -144,7 +144,7 @@ struct genericFormat *udf_get_extendedattr(struct inode *inode, uint32_t type,
 				cpu_to_le16(TAG_IDENT_EAHD) ||
 		    le32_to_cpu(eahd->descTag.tagLocation) !=
 				iinfo->i_location.logicalBlockNum)
-			return NULL;
+			return ERR_PTR(-EFSCORRUPTED);
 
 		if (type < 2048)
 			offset = sizeof(struct extendedAttrHeaderDesc);
@@ -153,16 +153,17 @@ struct genericFormat *udf_get_extendedattr(struct inode *inode, uint32_t type,
 		else
 			offset = le32_to_cpu(eahd->appAttrLocation);
 
-		while (offset + sizeof(*gaf) < iinfo->i_lenEAttr) {
+		while (offset <
+		       iinfo->i_lenEAttr - sizeof(struct genericFormat)) {
 			uint32_t attrLength;
 
 			gaf = (struct genericFormat *)&ea[offset];
 			attrLength = le32_to_cpu(gaf->attrLength);
 
 			/* Detect undersized elements and buffer overflows */
-			if ((attrLength < sizeof(*gaf)) ||
-			    (attrLength > (iinfo->i_lenEAttr - offset)))
-				break;
+			if (attrLength < sizeof(struct genericFormat) ||
+			    attrLength > iinfo->i_lenEAttr - offset)
+				return ERR_PTR(-EFSCORRUPTED);
 
 			if (le32_to_cpu(gaf->attrType) == type &&
 					gaf->attrSubtype == subtype)
-- 
2.51.0

