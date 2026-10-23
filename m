Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720005;
	b=UYvrHMywi6/PDDsBJ416tU7QA9gBrDCo7p+CfETSYvfJCXNrVY9A3YRizjaEBUUh0eGq
	 qXdCofh0455N7+onKiH6Gz29ebdIk9xv1tGcDWFF5XsL82xRK3CvdwRYDzFPRmTapUPMv
	 K+AnI2JaMx5mfqW/yDjo2RCvoOrSXQdDGzW4bdaOJxnpb14gJNg1sLENic2W3TpekQFWe
	 WlhDDM+t4b0WiUEZ8nB9IHF3d9K1dH++gs9ItYTcZ3/pBVI9WZIsfUy/D9wIZrDOG3jr9
	 78ZwFv8BCwi0HoTMyt/dece+jdC7rhoY5LvGmdZ8UjAQIDNFKOEWRUbZ6TyjP74yTmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720005;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=bjHGZQCvfX25OTz4vm8G1GJgJC0m33xE4sNWqA0JhGo=;
	b=McNnz168T+4ILtZDNPdTrGjsWRF2Zia9680kqtkhWK9PzAr3RwgzZX02XJ8fZz45eA2K
	 qVlKf19iL/MF8Ez+asd5NNJdRX6x0NBJgxrfZRAomW6tcAx1B2bhK2wpm3VJ0Qp9NFnxW
	 UoGcv728qwJGRnP8gb9HWooDRSu2uMuaaoMmBljBqXvu9C5QOJbEFMMsL2LXU4uhDZUql
	 aZnD0ntLwyvl3QARdzKl+5IMLRJKyo6HqXfH91jOUB1oDf+MjoJ3HMPtQ6xCqgeaX6cnT
	 /zhanPaPw9044mjorzAOE2+RGzToizkPkcu0hf3k1YZ4AGPar5fcr8JD7k0otc7jpqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ownmail.net;
	spf=pass smtp.mailfrom=ownmail.net;
	dkim=pass header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=Dr5J7xLb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="OX4/msuN";
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0DF606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 01:46:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE0DF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ownmail.net header.i=@ownmail.net header.a=rsa-sha256 header.s=fm2 header.b=Dr5J7xLb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OX4/msuN
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 247D71D001B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 21:46:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 22 Oct 2026 21:46:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm2; t=1792720003;
	 x=1792806403; bh=bjHGZQCvfX25OTz4vm8G1GJgJC0m33xE4sNWqA0JhGo=; b=
	Dr5J7xLbGHYubscrop0TD244QdIl+vImhvwwF9xIdoOqAIAa/sfR2AI6nkn04ryE
	P7pPrsuvT5nLnZmol+T63+hN6nqkPGeYKjnDDSY3tYRFmxW27HZ91U95joUWNPWj
	H2KI/bvCrV2sJE3VIPnsyVgFV3EM+UDKe9ejc1dAo3kFizbB/arZmYz6YJCnTbzV
	oIDsN014uJ8OgXA+rCFTMWFR4SUi59o9/dhYA6flAw1FUyLl4TLhmQ5ZleiQ5n7f
	bSyBJ3UMcJwJKbnvXihSCF9na4oyjR/t5M+vre6+usdsCkP/5lv/74vzgUbGg6Z4
	b3pkz7WQfeMgTAYx6ZG6ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1792720003; x=1792806403; bh=b
	jHGZQCvfX25OTz4vm8G1GJgJC0m33xE4sNWqA0JhGo=; b=OX4/msuNBUIx+qfS3
	icf4GYa/EmFHhDGnbiYoFgYvjiVb24iioJjTh6QRPTizdRIiJNINIFivb03FHMiT
	bTVSCQuogHWqbN4Lz5bw9xdauE4qiDPAEgubJfCJDAd5Zt1YjnSMpzyhjhka58xK
	Cv3yRW6W0c1zO5PpbrU8jWoUIO+N6ZEeTyFzTLe+7IMlHiEAoD5gCa3586YrR3gU
	h102EaOscNdjbkC7dpOZ43NY5qWOdh/v+VRU21UGrBqUMeqlU6CrFB8UBGJN9w3I
	6eQvD1NCDf5uiSabIbQKRGyuM0w9FGBStU9Yz5726Hw36qpE1jb3BNJJSN+KPoLB
	FF4xA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792720003; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:LsALTfHDZB0R+SIn7PMf+ohrDWFeVY3sQztyxy7cv4EYG/+
	7F/p1eIhUDIMV7bqftf1ovLIHiKo3LlekN9fpgjFZOs7li8gdqfT7cEev0gAAiJJ
	0njZ/Fr1V60rsesGOqtFyblQ11RVRY4fMxAwwI7pKI7XR2vycI63Fx9s2+LDZhVs
	t3Y1fpY2u6SWLpABfctWxUmMKQEtyUNTw0SFp7LYbMoZokT/nd2lr4OnPddS0WAa
	A1X0LCfXDg93qpu5WyeX1LgIRqZlNXeEDXy3rYlQKoZxQIrQfGfDEKY6JGO08W1N
	pt/PUwSkwLBknHlkghUfwk9zdmD7Nccme7121BA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,reply-to,subject,
	to;
Message-Instance: m=1; h=sha256:9TQ+uU2/b+zA9E9bFv6qMSV/DPMHpTatYugduM0i374=:AfQmjTSJOtLqNl0X3M5j4N+OqNgmcZeAo0fgsl/VOTI=;
X-ME-Sender: <xms:g7zaajxtpRZFh93vfzcRYiYYN7Mwv-EfhyL3RPpIk9AyGo8LtXUbGA>
    <xme:g7zaauVrWDCqvgNNcKgGzRNvyjhqCKbiYWrP2n9hlC-z2O7GqWugfPzwf4BMJKKgK
    __WfzUngeqsvZvrLKEzIyaE6sQ52QK-9xbluWcjxkBKiKo3xyo>
X-ME-Received: <xmr:g7zaan-Gz2_0aRwxfWrHKgLtCnJn34_6g7-xmnjdAK5jIFeWBH5bkyr7QEL8NEPvBH0dQ4qVxVBYW030V0dYdUOLMC4poDg>
X-ME-Proxy-Cause: dmFkZTGIvEnf2Th7X2Oi7hWodsjoWDPm8osLzyiWFkT+1WrqV4GWqpbbj9jlKTsoQCAQ+V
    M67SqmEAn84TLmtm4ACXe3jiHS0ENhF1RLgsH/2p8mIU45KV47yZDb39ikr1X43iA6byGk
    V1LxEwXXKgQ+NTyjAYyzFbdm0nceX4uiAUq3AQ0Gu+ZiKGi9rB8emb8wSU3k0FnXZEdtr+
    WiEz/dW8cXNpjbWMmEMsZTWvqe3QtsxBK5thmMAFzmuNk9/k6KQmyG3H2d0aNK9gR72V49
    EcVNML0qZ8Aw1eY4XNIg74h+/WwcYLkRzUCPNha6wapC8hOLmqzgVXUpZAjOs13tUt4vNI
    8N0h8ZNMWqb/rZ2inzzd8DCh5GxvmchS6iWMiHw6JvdO3FhfgHx+7rj5hFow+lgnMPX/1O
    m5qrJnC08tPX3CO6yP6x+wroAJl6d9iobMx6S6CYkKsjlGuhB05Ay5JZLzVciPcSx5O+wm
    v748G2TDUoUaWRq/Q4PSyGy7GP5776JAshIlLmihpz34ztaaUSCKwKP9JRYMfEhrPQm1CG
    be/eeisAz2VKa0J+EvTPt8wUlidWgLMq9a1na/dOGYH7idzn3ftan9tJ4OlFKbdYfg7Q+K
    VZhKqDiVwb8D96LhPHe94DWnCAHJlBzF1O5a0m2QRDPiuemQbBOC8yINDoHA
X-ME-Proxy: <xmx:g7zaapvVSAbw4oA8x2vcte-keX844_weZj0JhM6H2p5GNoSKtPx0XQ>
    <xmx:g7zaav2dkAXlY0-HA4tNXEdWdhZX4nG-u32FwRStKg63WGxzBTfBUA>
    <xmx:g7zaamSjMho0-PcTHhO4L9GCn47u-3zohmEt8xjiPESbREmIJFhPfA>
    <xmx:g7zaarcrBohYqBCELRAxfuw_Zlwn9NPu3gKc-AFeNzdnP2igLP66eA>
    <xmx:g7zaalhZkZ8FuAILE7GoRQo1r5s7caYkJpDWG5mkwZlMi_GqHdU6GDLQ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 21:46:40 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Paulo Alcantara <pc@manguebit.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] smb/client: use d_alloc_trylock in cifs_silly_fullpath()
Date: Fri, 23 Oct 2026 12:40:24 +1100
Message-ID: <20261023014211.2120871-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20261023014211.2120871-1-neilb@ownmail.net>
References: <20261023014211.2120871-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
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

From: NeilBrown <neil@brown.name>

Rather than performing a normal lookup (which will be awkward with future
locking changes) use d_alloc_trylock() to find a dentry for an
unused name, and use an open-coded lookup_slow() to see if it is free on
the server.

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/smb/client/dir.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 4b0a402a6991..3a1263746ed9 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -1208,23 +1208,36 @@ char *cifs_silly_fullpath(struct dentry *dentry)
 	unsigned char name[CIFS_SILLYNAME_LEN + 1];
 	int retries = 0, max_retries = 16;
 	size_t namesize = sizeof(name);
-	struct dentry *sdentry = NULL;
+	struct dentry *sdentry = NULL, *alias;
 	char *path;
 
 	do {
 		dput(sdentry);
 		scnprintf(name, namesize, CIFS_SILLYNAME_PREFIX "%x",
 			  atomic_inc_return(&cifs_sillycounter));
-		sdentry = lookup_noperm(&QSTR(name), dentry->d_parent);
+		sdentry = d_alloc_trylock(dentry->d_parent, &QSTR(name));
+		if (sdentry == ERR_PTR(-EWOULDBLOCK)) {
+			sdentry = NULL;
+			continue;
+		}
 		if (IS_ERR(sdentry))
 			return ERR_CAST(sdentry);
-		if (d_is_negative(sdentry)) {
-			dput(sdentry);
-			path = alloc_parent_path(dentry, CIFS_SILLYNAME_LEN);
-			if (!IS_ERR(path))
-				strcat(path, name);
-			return path;
+		if (!d_in_lookup(sdentry))
+			continue;
+		alias = cifs_lookup(sdentry->d_parent->d_inode, sdentry, 0);
+		d_lookup_done(sdentry);
+		/* It is safest to return -EBUSY if there is an error in lookup */
+		if (IS_ERR(alias))
+			break;
+		if (alias || d_is_positive(sdentry)) {
+			dput(alias);
+			continue;
 		}
+		dput(sdentry);
+		path = alloc_parent_path(dentry, CIFS_SILLYNAME_LEN);
+		if (!IS_ERR(path))
+			strcat(path, name);
+		return path;
 	} while (++retries < max_retries);
 	dput(sdentry);
 	return ERR_PTR(-EBUSY);
-- 
2.50.0.107.gf914562f5916.dirty

