Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F72247254F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333653; cv=none; b=TPFojv7/rVkK77KkFvh3SitcZ6xpcjnmxVs4TmMzdVIUy+bubx4SV2BRgqlDSu7QwgLhjmhWyfvo//CF5wNtvz9snG+7W1Uk+VJ4y1kfGlG7OH7pnyJJBF0GUXKd4/w7aBsrL9pMhwfn84i7Fib1U4jgpD3o0YiNXftINVQ5O4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333653; c=relaxed/simple;
	bh=E9adSgpPNqLGaL6Gxe+Dd1ghUtNkwjChdtqwrf+Us+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q4gzpg7D9NHMnxC7ISLMGrTkqjdYKB6AcF3GDMD3Bahh3tpLxzoCdScW8ptrgetCEFCi1xVV+UldicvKxVXsnlbP4CN1/ldlEeXiJ8oQYA+NHJoLdqCR3APbU0cIMMnqpT2tJFv5UuGsVgPfs+Vo7FnqZb3bUdkSkvbS7BzNGxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X4hndjam; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=19GNC61J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1xUEORzv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D1aj5xtF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X4hndjam";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="19GNC61J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1xUEORzv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D1aj5xtF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A07157B7AB;
	Wed, 29 Jul 2026 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785333643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H7cOxUgGBlJLCWAnBNfeZnOWq+ylVKoMWqmA8ZxEFqY=;
	b=X4hndjamdZZ9/Re/3TarLEkMiCVTU9+APJFwGYwlYkFx7u+cPUYrWmOwnfc6vBgrpf7+2f
	E78XZ4LxIlkt/35/dT05zNYV9Cj87R1kBhnGlYZec+JNvGrOZxTrkFXa/wBbMUJgmJCHuh
	ez/t3H/gzZaLneGCdVbtPmEmUCZAHB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785333643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H7cOxUgGBlJLCWAnBNfeZnOWq+ylVKoMWqmA8ZxEFqY=;
	b=19GNC61Jy6IJw2zMTl395IHZ+lBwGAC1L7W+R9IZ/n3Rz63LcFrM95bMivAJDCRo5wSSOA
	xeoIJ3UT3UajZODw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785333638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H7cOxUgGBlJLCWAnBNfeZnOWq+ylVKoMWqmA8ZxEFqY=;
	b=1xUEORzvGv2iAEz56pVcBnypcKBq/fAPDWcPcQfb4Q4ldbX0n/7gmfHYjJyHNoszdxU7Tg
	MPI1AjXFdUURTDOl/5ssdAwOnzR0A1rL8UuH7TbwXAKabBp5ZCT8VMaycNB1FlBXEVBUrr
	3yhemUoKaRlSv//UHxOj8ef6C1gbGJY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785333638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=H7cOxUgGBlJLCWAnBNfeZnOWq+ylVKoMWqmA8ZxEFqY=;
	b=D1aj5xtFINLbzAI+Fx/YXOIXX55H0q4+Xk2GRoJ7ad9gMWEDtpCnd3U8Y+1QmwJauqv/Gr
	C9PxXD/j/M1py9Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 97E14779A1;
	Wed, 29 Jul 2026 14:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RtAOJYYHamoKGwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 Jul 2026 14:00:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28F1FA131F; Wed, 29 Jul 2026 16:00:34 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fsnotify: Remove Matt Bobrowski as a reviewer
Date: Wed, 29 Jul 2026 16:00:32 +0200
Message-ID: <20260729140032.4022470-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RSPAMD_EMAILBL_FAIL(0.00)[linux-fsdevel.vger.kernel.org:query timed out];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Matt was not very active reviewer in last years. Furthermore he
apparently left Google and his email doesn't work anymore. I didn't find
any working contact for him so at least for now delete the entry with
non-existent email.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

I plan to merge this through my tree.

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..a93e2cac04cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9907,7 +9907,6 @@ F:	net/core/failover.c
 FANOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
-R:	Matthew Bobrowski <repnop@google.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/notify/fanotify/
-- 
2.51.0

