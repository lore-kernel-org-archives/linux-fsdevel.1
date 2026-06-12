Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE2368D6D;
	Fri, 12 Jun 2026 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250811; cv=none; b=JJs1EMM53QTT74cGFyTrZ84yuXgUrZvh9tWddZCt6AZLVXyWBed0th+PPgqyUv2FK6cheGcvrZWGbRKqe7zVPIPvAUUtOyR5puUpl9tOd5bmaGNIqdLX/AhUBR9HaahMBgpgUp3t6p18R5f+pe77kF1iE87TQTRf0HSutNHg6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250811; c=relaxed/simple;
	bh=7cxOJuEQNnpBJ9lBVpzf2+5wmzNoLsNQFibTzzhQHns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A2Id5vVP2spLaNRhZLZGQ8wXOJbcGuro6cCCn56Q5pT5FOwkpB1NjwFpVwoX389EhyVf/YCpSElqispakn4CRccbJODVji4os8G0toxrQBZyoBaFz79384jy8kBqgs0+9dChtErNvEO7YLP8DOyf7rlsI2KKrXlXYyYY5aBAfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PPZ+bdCb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPZ+bdCb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 620A9C2BCB8;
	Fri, 12 Jun 2026 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781250811;
	bh=7cxOJuEQNnpBJ9lBVpzf2+5wmzNoLsNQFibTzzhQHns=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=PPZ+bdCbw2YIrArjlhoDWsoSXtocuJsa9oX5A2X2YcHISY1sm4GyD8fSTYGsi7QIs
	 iTO1sh/R+AIfqmGU6+Y8dm5adJXKUtMHPYWQR9rvbkiwRjKJKXi1bGJHoaVhK0N1gu
	 kfJ3VPxq6U2lHLXvLPTDpwj81gMDs98xBoare3nDYxZsF5IzK8YIDVR99RPMD6cfjA
	 d8QBGeSKa8xQCh+u7xm5QRDWmiTSRYlDvGt0AXUdTFTcFjI351CkxT26ZUi2WSE/xS
	 KYKgzQLvGiIuRTawYob2ng1CVpSj8wGorStGGW7lccnjBJvjhaQUAMtmd2lKgiMh5/
	 mZz/tgaOq0VJQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F15CD8CA8;
	Fri, 12 Jun 2026 07:53:31 +0000 (UTC)
From: Bryam Vargas via B4 Relay <devnull+hexlabsecurity.proton.me@kernel.org>
Date: Fri, 12 Jun 2026 02:53:31 -0500
Subject: [PATCH] udf: validate VAT header length against the VAT inode size
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-b4-disp-9a2317ee-v1-1-fefef5736154@proton.me>
X-B4-Tracking: v=1; b=H4sIAPq6K2oC/x3MQQqAIBBA0avIrBvQyYy6SrSwnGo2JQoRSHdPW
 r7F/wUyJ+EMoyqQ+JYs11lhGgXr4c+dUUI1kCannSFcLAbJEQdPremZUWtLfjOddT1BzWLiTZ5
 /Oc3v+wGBXm8NYgAAAA==
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781250810; l=2153;
 i=hexlabsecurity@proton.me; s=proton; h=from:subject:message-id;
 bh=ZY17IT0BpaH4FEeyUQ1+9vxWALoFy1Q9t97ot9RCyJs=;
 b=+hWVDf6Al1o+d0WlLuXE3/T5kRNm3+rLfWn/Ysq5l85AMOnIiBzRi2ffmKiakyOM8zxBDbIU/
 M/0g3zukuj6Bl0eLeNL2qQ1X+NAI77/4pQfNbQl8MR0n5nBIsxeGF1l
X-Developer-Key: i=hexlabsecurity@proton.me; a=ed25519;
 pk=dmppBMZNLLoPzxHi9l8tZDzEZUunPbgsYqIZYXeUrL0=
X-Endpoint-Received: by B4 Relay for hexlabsecurity@proton.me/proton with
 auth_id=814
X-Original-From: Bryam Vargas <hexlabsecurity@proton.me>
Reply-To: hexlabsecurity@proton.me

From: Bryam Vargas <hexlabsecurity@proton.me>

udf_load_vat() takes the virtual partition's start offset straight from
the on-disk VAT 2.0 header without checking it against the VAT inode
size:

	map->s_type_specific.s_virtual.s_start_offset =
		le16_to_cpu(vat20->lengthHeader);
	map->s_type_specific.s_virtual.s_num_entries =
		(sbi->s_vat_inode->i_size -
			map->s_type_specific.s_virtual.s_start_offset) >> 2;

lengthHeader is a fully attacker-controlled 16-bit value.  If it exceeds
the VAT inode size, the s_num_entries subtraction underflows to a huge
count, which defeats the "block > s_num_entries" bound in
udf_get_pblock_virt15(); and on the ICB-inline path that function reads

	((__le32 *)(iinfo->i_data + s_start_offset))[block]

so a large s_start_offset indexes past the inode's in-ICB data.  Mounting
a crafted UDF image with a virtual (VAT) partition then triggers an
out-of-bounds read.

Reject a VAT whose header length does not leave room for at least one
entry within the VAT inode.

Fixes: fa5e08156335 ("udf: Handle VAT packed inside inode properly")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 fs/udf/super.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index cad2e15d633b..561eace476ab 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1263,6 +1263,14 @@ static int udf_load_vat(struct super_block *sb, int p_index, int type1_index)
 
 		map->s_type_specific.s_virtual.s_start_offset =
 			le16_to_cpu(vat20->lengthHeader);
+		if (map->s_type_specific.s_virtual.s_start_offset +
+		    sizeof(__le32) > sbi->s_vat_inode->i_size) {
+			udf_err(sb, "Corrupted VAT header length %u (VAT inode size %lld)\n",
+				map->s_type_specific.s_virtual.s_start_offset,
+				sbi->s_vat_inode->i_size);
+			brelse(bh);
+			return -EFSCORRUPTED;
+		}
 		map->s_type_specific.s_virtual.s_num_entries =
 			(sbi->s_vat_inode->i_size -
 				map->s_type_specific.s_virtual.

---
base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
change-id: 20260612-b4-disp-9a2317ee-0042af154672

Best regards,
-- 
Bryam Vargas <hexlabsecurity@proton.me>


