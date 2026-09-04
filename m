Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209642E429;
	Fri,  4 Sep 2026 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788558839; cv=none; b=fHfNKn7IEBVIimODG8cNMbFr484COPeQCVM08z2fz7mmxyiC6Sew0TqNeCQLOM7/rjR0WYAzMfziABugxy1yOq8uHEaKFlaIzhOi0SHLpSYkYQO/w/0nvwVciC0N65P7VNCYXKGJbSo78j+YD7u0nGVMX6xIsxT7ONskxW+DFjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788558839; c=relaxed/simple;
	bh=aUs/PFLLTaGein3PyaTaOoqZxfDY7ORzzk9KelrvCqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwVkQ+xQmdyE9kEbHLiup1gQGXmJZdAt/oLdUhJp8aIgLZa3kVwObxpCXDC7wczv1kHqBW9tXhdJFYjzvVSwEAcSQ39CmcnrSChC+RssSCz/2RD8eFXgPmog1lzWY7mqkwfTJvuIfugnE8XiPOQlP6HY6/9Ape1mp7iNCw3RC5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=COanBLnm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NvXfjivQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="COanBLnm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NvXfjivQ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5FC891400156;
	Fri,  4 Sep 2026 17:53:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 17:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1788558836;
	 x=1788645236; bh=wj/MnL34RixKciPgZi/7laRXXNimZ5XfwnqNuzhacfk=; b=
	COanBLnmXJBIoT4hDX+ScO9r7qdGdcBWmGAgc7K6vQw37b7pCmWtNpTuSW//1Z3y
	itNxaevYlAt9zrW1t1ZdP+ttLh72ThRTdKNE6eEtzdRwMUq3K3frhlSaTXE3z2AZ
	YwBIlc9sCBnjm37cRpNgn7z2T9dWy6R79YijSJipS1FZkIBPfBqbZUmQ0NXLR77L
	YUJSj9IYPR9Jztln+bi3wqg5NPcenCh6n6NjrGYMx/fQXlBJTCwbDdPSnGEBAStW
	/Q+nsawOmJl9Y9UuD1h82EahTtiSQr2BkBAfrw5+MFULVMGcl7/f50nYpdiBJtP5
	SHMoP1uQ9R0ZJ8orCyMatw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1788558836; x=1788645236; bh=w
	j/MnL34RixKciPgZi/7laRXXNimZ5XfwnqNuzhacfk=; b=NvXfjivQbyX1+xS3v
	7k91TGS0rsUcyjxGrgYuZbdnTwqU/Pdk8gweYzWYT/4+r6LsBUTshJOszLurUDLa
	mB7K1+GNLJVPHP/eYejpcCc8Oy/yXrcP8sJvjw8aTnb0uYIQr4sfT2PnSOReLWlY
	/cCuKrlwt9pjZV9ascA5M0xWm9yp2UzB3Jjso1NeImSrvVgEau95vBTJM1O7VNar
	bKcczJMCFusdHf93Z1veM/NOhk3/VdTqUnAIo29vlwhVr1kFeGXPAyeXIuaqylwK
	yQenLPb/17/Qtma27402ngz+8j8EXVHKNoif0EsFFMVt6fNNZ1YFUyJBd58iLuwH
	kifpw==
X-ME-Sender: <xms:9D2bapooYyNcfqDe9WUA_SckSiW0c_KuZfdcO2asN8Ltic71SzM5RA>
    <xme:9D2bauOFXlT31zXHrDrnBsZQaAElO8bLZoen6jDUSM-yWMqAp5TS9vgCH4rqyCn_C
    3R1HTCiqrko8EPYLTwJCQFTYrEdJ4iISDtXBn-lEswxHS6dhO4>
X-ME-Received: <xmr:9D2bap3I6qb3EgImiuN3X6enw1Q__PvV4JG6EjyrBejjNyCmgxsyI8UCrQDcddNn4Cs3oB_2o7WZFrBV802VyoqvJdfBHC4>
X-ME-Proxy-Cause: dmFkZTFiAOSj3LUvbMyTizwFG8S0Z77/oyH2J2g/uycK/oy+xjfWiF27uJMr9H7g3QAOe/
    XYsAVApeSvodxh0nJXqm+2ih0Zs0UFQnZPCwAsQgYJh4bKlGJCxAFvJ28DiVFZcSJ1v4SN
    eyofj/RHn+C6wmmzYsHzdQWXaMLzQ5qjTmyCk6u6FNaJzHTyX3mRZJWbQlLecUBL+8R9uF
    oXPgTkabZ8M+0wwMRuzFqlmpEXjU77OKNTiGAEqZPKyJRGqwLIf4volXBc3DcquHRoaijA
    Ked+eKVy/8jzE5J4p8iliYop7ExvhRi8QZDkpUnJW3mwzA4SzmVm5+ia17mBgI6SpbQsJH
    CygeaM1INM6cV32x4VYKeOonKyzLfyPCrxqNtWdoN4AcYkpPdbaw5na1oFweMamG4+s97P
    E0+ufaUNxi9a44fopeY9q6mozrO6UECQTg0xSxcbPpFoZhjJpnGa+cuoVSucT00a/BRs64
    W7U6CmfL+/CGBzf7/E0gB/+MpBctZkhHg/jFUjGxMVdgwm5Q7oVSsX3WUFxW4njTGEigaL
    /22TAynsvaT7AuFF1504Qwk1W9BWrrOfRuPAmEcjvGD9w9OZGFl4QFyrYTCw24DZfjTiAn
    gguwTOmjMjpBWkh29HetTdQscDxX1JaOgTVb+Nomk2WqV8cGnB8tUUh8+AkA
X-ME-Proxy: <xmx:9D2balAufSa0JvlDPzwfaK_WI_EDk0wm39xWTfhzMMxt4wToOonWEg>
    <xmx:9D2bauLHKG63jtU65aUCkqOXB2Fe5lBccWhkg4Caquxll9TK-iP5sA>
    <xmx:9D2bamnd69xAM3mztGTGS2eRTyMPIk889X4_AgoUiaUn32l0fPI3eQ>
    <xmx:9D2bavaXLO0FjJyA55hLHFGiS6UuRiDAA6owSOxIRYPh2VuLXtF6aw>
    <xmx:9D2baoSPnS54lgahcKrJVcNYGPEyTBRcgYObDe2xlyZpNKrZSQkQnonq>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 17:53:53 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 7/7] VFS: reserve a d_flags bit for fs-specific usage
Date: Sat,  5 Sep 2026 07:48:16 +1000
Message-ID: <20260904215142.1060510-8-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20260904215142.1060510-1-neilb@ownmail.net>
References: <20260904215142.1060510-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

DCACHE_PRIVATE may be used by any filesystem for its own purposes, much
like d_fsdata and d_time.
I plan to use this in a similar manner the way nfs stores
NFS_FSDATA_BLOCKED in d_fsdata.

Signed-off-by: NeilBrown <neil@brown.name>
---
 include/linux/dcache.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index e7e3ef05313b..adf239f8205f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -238,7 +238,9 @@ enum dentry_flags {
 	DCACHE_PAR_LOOKUP		= BIT(24),	/* being looked up (with parent locked shared) */
 	DCACHE_DENTRY_CURSOR		= BIT(25),
 	DCACHE_NORCU			= BIT(26),	/* No RCU delay for freeing */
-	DCACHE_PERSISTENT		= BIT(27)
+	DCACHE_PERSISTENT		= BIT(27),
+/* 28, 29, 30 free */
+	DCACHE_PRIVATE			= BIT(31)	/* fs-specific flag */
 };
 
 #define DCACHE_MANAGED_DENTRY \
-- 
2.50.0.107.gf914562f5916.dirty

