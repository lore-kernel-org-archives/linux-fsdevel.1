Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1B25B099;
	Fri, 24 Jul 2026 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784862629; cv=none; b=U8E+XqjDDzdLJfVQzZ2Iyt7XBRycJtTT6tMlMPX3yvc0gdVEJ20qiMtjcTco/aS4q2bGREmWvsBLD9euI5Lchux+QwXa701ZNfbdyJSa4oZXz23dU2ScfZpoezoIo/vv+J5CPxja3vVz3kRrdu8ZnLehWFisoN9gsh9LYDGkFWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784862629; c=relaxed/simple;
	bh=Ha0j2A+49c+Omg9gD8zMv9bZ/Ah3K2ikBGudx8WfQRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QUnpTnIlB+saPke4aiOKRwq+s8x82qMciYh7vjbaVUSEAfcnC5kk7DR4B9DAmmE6H2Sixr7Cme/TrD3P1E5ZvDUVVIKQuxa1J3+OuWBLlYhiicnehmNY+ain1/WGReFtfRJvSqqHDfejlIHCWjB2I+7A7nb4xtNStYVxy7qflpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zGcwLGYn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zGcwLGYn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IQbYVxfub2V8PKeydHYMxdp5JquhIsMXm4HlwceclnY=; b=zGcwLGYndTgSuEFVcpT1AgzphA
	MI4wzaTxZCQrqHN6brgiPKyqZSyiLOqOrz5suvxlCg60n8rm0Atr014vVzw1jsJwApAW/dOGEH+4M
	rQRcJlsT1bX4GOD0nHitRLfVPjWGweiQmEuTHS5VWoTKQXiNgFVnUVe4+ImF2y2aIu1AU4eawigSf
	3r0rdLqb2rSlbfvy0QZAnEHXKP5Oj5ZYaov572ndYjqNzAv3/3HQUYaWXOLjbmG1OMeEdOf/hOzuP
	qk123YLHeVzRSfFVsw+gVQR8U9BRRsk3aMW8thvnXODYrcDe+VdVuw1BXTvEQqv7Og7JNs0xeiq+g
	tEbBiWSw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn6Ip-0000000FQF3-0vVl;
	Fri, 24 Jul 2026 03:10:23 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] nstree: add/fix struct ns_id_req kernel-doc member fields
Date: Thu, 23 Jul 2026 20:10:21 -0700
Message-ID: <20260724031021.814599-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- drop non-existent @filter
- add missing descriptions for @ns_type and @spare2
- change the descriptions of @ns_id and @user_ns_id based on their commit

to prevent these kernel-doc warnings:

Warning: ../include/uapi/linux/nsfs.h:117 struct member 'ns_type' not
 described in 'ns_id_req'
Warning: ../include/uapi/linux/nsfs.h:117 struct member 'spare2' not
 described in 'ns_id_req'
Warning: ../include/uapi/linux/nsfs.h:117 Excess struct member 'filter'
 description in 'ns_id_req'

Fixes: 76b6f5dfb3fd ("nstree: add listns()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: netdev@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org

 include/uapi/linux/nsfs.h |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- linux-next-20260722.orig/include/uapi/linux/nsfs.h
+++ linux-next-20260722/include/uapi/linux/nsfs.h
@@ -96,9 +96,10 @@ enum ns_type {
  * struct ns_id_req - namespace ID request structure
  * @size: size of this structure
  * @spare: reserved for future use
- * @filter: filter mask
- * @ns_id: last namespace id
- * @user_ns_id: owning user namespace ID
+ * @ns_id: last namespace ID
+ * @ns_type: bit mask of namespace types to include
+ * @spare2: reserved for future use
+ * @user_ns_id: filter on this user namespace ID (or 0)
  *
  * Structure for passing namespace ID and miscellaneous parameters to
  * statns(2) and listns(2).
