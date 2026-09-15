Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E93B05AF
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 09:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465668; cv=none; b=N9lvzlvpGdVy/0UymaT9eglx1Msrf6xS1iDmSvH8nu/KfzR116t6INDJuLxd45I+ilNacKnmR6T1GikWQtyvDmNdCp9N3WnUMgOMfH2G58wIjLhKaliZGIa0Id+V0hz7xfb3H5W2CJYDIYs7xuBVr4S+jPkl1g2E+F77IfRPWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465668; c=relaxed/simple;
	bh=dILzd+u0jSB+GxtsrfFrtAHojQAZPt685SKje2iAiqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHpr/xPN9iZyXo8pv6FlMRAbP5McOccF78NIoYIEw7yLbYXLYrMEi3ex6aeoqB/mFU/m3eLMk2iJKCr3i7IHCjF9jw8OkiB3ie+ou+b/i7FC9kPTz2Pm3FB0jKgKVbSo6WrSpDY20gob8BbmpXY9V7y5VE91lDffSkBQPFemohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gOfm5TF0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VQXNI1uQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=16h7BDIT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+on6qyR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gOfm5TF0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VQXNI1uQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="16h7BDIT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+on6qyR"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 298C71FAA3;
	Tue, 15 Sep 2026 09:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789465660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q0P0niFi+511EWMRf/3l07gnLe35h+ESNvaD9mBuWnQ=;
	b=gOfm5TF0Fgtclc/wfYR9audBFLnJNudTzfCNbvwHv4qMSj0q/FXuYUPtUmGTO14NnavLX1
	f08dq5YTixTmI11bAcQES+QnBVqA5giZEli6jjbG1+wdlOElNVjNTI3ZgnUVE07MSRXBgl
	PaBiiNzNo54j7TVtqtR/ITr20NziSSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789465660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q0P0niFi+511EWMRf/3l07gnLe35h+ESNvaD9mBuWnQ=;
	b=VQXNI1uQl+A7mbw1JGYc8rGUAqS7pZ3WRoVrxAnY6MNDI7mo0I9yCleZNYb5NCOxVnq8kk
	KeNp6NPEJ8ulezCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=16h7BDIT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y+on6qyR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789465656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q0P0niFi+511EWMRf/3l07gnLe35h+ESNvaD9mBuWnQ=;
	b=16h7BDITrzoA6jY2ZECvgabIDUdkizPTcXL6tN5680WtsQxVx+gSRkm8fmzxXxcwJofoKu
	72cTU9ISc3Sb7aufO2p9gw6J0qaTN3ANJQ0QPJDSg1Q634xlgsmcoHnavSjxKZeAwl7eBM
	kAOhBs7TfrhmquuRzpIaeccpy97llJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789465656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Q0P0niFi+511EWMRf/3l07gnLe35h+ESNvaD9mBuWnQ=;
	b=Y+on6qyRWQB0YLcVMuR+4MC0rBPA88elHI52UWwLsztYTAuGkirHao3vqWuY8B4d7rA+ly
	oyTr0rShxU0TBuAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0300613693;
	Tue, 15 Sep 2026 09:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1rcgNDcUqWpJfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Sep 2026 09:47:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 894C0A13D6; Tue, 15 Sep 2026 11:47:31 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Matt Bobrowski <matt@bobrowski.net>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] fanotify: Re-add Matt Bobrowski as a reviewer
Date: Tue, 15 Sep 2026 11:47:19 +0200
Message-ID: <20260915094719.2034706-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 298C71FAA3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,bobrowski.net,suse.cz];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

Matt has resurfaced and I have his working email again. Re-add him as a
reviewer since he hopes to have more time for that now.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

I'll merge this through my tree.

diff --git a/MAINTAINERS b/MAINTAINERS
index 627595e245f3..6b698f8e52e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9975,6 +9975,7 @@ F:	net/core/failover.c
 FANOTIFY
 M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
+R:	Matt Bobrowski <matt@bobrowski.net>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
 F:	fs/notify/fanotify/
-- 
2.51.0

