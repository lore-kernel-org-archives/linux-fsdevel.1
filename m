Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877457;
	b=1m5fKLF7jAatzmsV50TVKncN4+i1q/meabslVZBuzf1JTjV3D3+ieGX+vOl8zKITR1Ow
	 rj8x11wWnp990m3CSsQBD63Dwn3V1k27OJa27bFUOVARiAY7Dxrf/fhCEnDMj6fArkcS0
	 Qn2NpocMWtYRtbV4104sGuuLlTecYH0rXHOhNuVuGNnKP/aUTwUStECV36GdcPwtPK5cE
	 2T28lVUGCJFhjfw3DzyX093AWLn9omFnx8vFpTfQ2L28Ij5DfeTN+X08vOqw7ARBq+i0K
	 LKKQbgZRIqjis7OEZNC2TTiOtGdxs5ftHe5WkjyOs78tNi5Mqkb5RZ3vdBsf0T1oE9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877457;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:X-Spam-Level:
	 X-Spam-Flag;
	bh=HGeghjMwd8bU0tO9n13zGes15k53yxgHh8nlgduirag=;
	b=duO8cwbDa3MYditSoZaJBeCOu2GQI0FavK3B2Jk4XrPvT6bJc9DRD92hBJgxxWH3+OfL
	 FKnM+iHczBP1Cs7GUHtbKKraKEm/N/0OngiTiqGMiA9dHjGHb9nLqG9kI2QaFrhXl4X8n
	 Y8KvckiF5ZPghA17WwxuegJ7gph1501Td3BhUj87v61Wwshz5/w+/BE9VuvdsImBFbs07
	 5cFAb6E4SUW2dqdB20UthbBVghyGwAwfjRYKV5+WDRPYKH2q8wlI1saTbvdfN1wvF8DZC
	 r2nspzj+MDX83wbijMB0hRYcxSz68FSCqZzKjNsw1m9Wig+j3pmrH2aqhI2p24uXWXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=F4btvaI+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ncysa+7A;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nb9VdBqa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BSvTFKbK;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F5606A31B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 11:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 786F5606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=F4btvaI+;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Ncysa+7A;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nb9VdBqa;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BSvTFKbK
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 906A81F387;
	Thu,  5 Nov 2026 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGeghjMwd8bU0tO9n13zGes15k53yxgHh8nlgduirag=;
	b=F4btvaI+5jqYUIx9KClIZMLVlXp0Tiof63fdUF8eWiUhtszQC7DLd8dF+druln6Z885rkP
	Z2UjzcpdFv+MB5r1bX6ZlAmxRcMSm3ZE2+wBeLz8IppE0Fd+KmVIkVZ1UO809FYu8If9qG
	w0cbS0/3OkiAWWuZJ2rHM1lkvmhxOIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGeghjMwd8bU0tO9n13zGes15k53yxgHh8nlgduirag=;
	b=Ncysa+7AVPJzT7Ac1WtxVxg34ZDkW08/+0kKl4qVxvszWjRFvv+iJhKiOeiheA0dNlf5Gq
	jR7ZMQ31NxirsTCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGeghjMwd8bU0tO9n13zGes15k53yxgHh8nlgduirag=;
	b=nb9VdBqaZerblqQGFWMeVtYnnwfYOnJJGedqO9E55OQCTENZDbCuJxXcYR9NaGO3+/+IYu
	GItxsxjTDTI4MZbdKAV2oSkfY6xCjNqfTYBM4asUi5WwJTg8tBqONprByEeeQYr354ywW+
	4aRDa9QBCRokFmiIPUJ9pBDvLGZfvFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HGeghjMwd8bU0tO9n13zGes15k53yxgHh8nlgduirag=;
	b=BSvTFKbKll5LGFzU72sugpM3vAZmbJQhQX/wDus/4U/S4Gx04qXP4+d0FHdgbESSKe17dU
	m78jdKOwEgnNVzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 934B0134F4;
	Thu,  5 Nov 2026 11:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j89PKbpl7GruWwAAD6G6ig:T2
	(envelope-from <ddiss@suse.de>); Thu, 05 Nov 2026 11:17:31 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Cc: David Disseldorp <ddiss@suse.de>,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH 1/3] initramfs_test: drop dir data segment from PATH_MAX test
Date: Thu,  5 Nov 2026 22:09:59 +1100
Message-ID: <20261105111654.214569-2-ddiss@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105111654.214569-1-ddiss@suse.de>
References: <20261105111654.214569-1-ddiss@suse.de>
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
X-Spamd-Result: default: False [-11.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Flag: NO

initramfs_test_fname_path_max() exercises the name_len > PATH_MAX filter
for cpio entries, but it does so with a data segment attached to the
S_IFDIR entry, which doesn't make much sense. Drop the data segment.

Initramfs extraction of non-file / symlink entries with data segments
can be explicitly tested separately.

Reported-by: Avi Weiss <thnkslprpt@gmail.com>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs_test.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/init/initramfs_test.c b/init/initramfs_test.c
index 1154547721eaf..a1e88336ca3a9 100644
--- a/init/initramfs_test.c
+++ b/init/initramfs_test.c
@@ -465,11 +465,10 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 	char *err;
 	size_t len;
 	struct kstat st0 = {}, st1 = {};
-	char fdata[] = "this file data will not be unpacked";
 	struct test_fname_path_max {
 		char fname_oversize[PATH_MAX + 1];
 		char fname_ok[PATH_MAX];
-		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3 + sizeof(fdata)) * 2];
+		char cpio_src[(CPIO_HDRLEN + PATH_MAX + 3) * 2];
 	} *tbufs = kzalloc_obj(struct test_fname_path_max);
 	struct initramfs_test_cpio c[] = { {
 		.magic = "070701",
@@ -478,8 +477,6 @@ static void __init initramfs_test_fname_path_max(struct kunit *test)
 		.nlink = 1,
 		.namesize = sizeof(tbufs->fname_oversize),
 		.fname = tbufs->fname_oversize,
-		.filesize = sizeof(fdata),
-		.data = fdata,
 	}, {
 		.magic = "070701",
 		.ino = 2,
-- 
2.56.0

