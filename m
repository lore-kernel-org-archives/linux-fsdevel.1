Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877439;
	b=zu1uJ3aRG3Hiuvn9+MOL2rA5orrAaCaG8OhoCeMpykuDfW8bM7TfiQWCfbxmScECesNG
	 S0b/ZLGCOzI64rggykIQRKPV1L7CFxHGv7qzRFIIFRA94aVZkQ4yUK9nUzbUOmiBZFFrY
	 8OaYYSxPD+WcmFeW5PIR/nPjUeideIXRYFAhyeAuknHzrI6QY1RcG7iDD6rVpJunB/HOU
	 4n2aaJrhv6yLF5HIjPbJM5vEoBAJUZx4+TH1aX8wYcbOxHYf8uhqKeU0Zga1Thoc8F89/
	 CfCBszCENBBh0p3R+vzmjwPtbye4X85OjGRKbLoCFIkoSNG+5fGlLxBzcVDuLx0XKmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877439;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Rspamd-Queue-Id:
	 X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spamd-Result:X-Spam-Score;
	bh=6CuA3OIZkZ8wIZVdUxFG/6XcKxuWeZ0VTf1oMbAQ6EY=;
	b=Gu/6SZW78Cr+y+rz7iur+WE2bTyoZptwc3S9+n7tUWTpecLV4IBd4DZ2XUWN9SsBLwGy
	 pIQoWDCM4x4V3c9HNALf3VIeXm2VtCWU94WLglo949M0eVbjPqw1pvGLkBaBHouQF0nCT
	 BNerP9AkMJimx7iXxtdM2/vB9HyCgKZrvd3LS7MDRfamSITM8WJyoClTknywbydedSwWB
	 eMxWOS5QQlFfjgEJpCdcNmsKNiE9c9o1NabgCaQbuDdVAUxLCe5ou1H+RYb5/A3bD4Kn0
	 lneUkrs387qKAs6P4h9wUSWAJs6mkUd4QXD/+FYcexoRzs63CTVD7AhWs7jugu7c8+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EtiogY1x;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WOH9pxMc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EtiogY1x;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WOH9pxMc;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DADB606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 11:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DADB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EtiogY1x;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WOH9pxMc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EtiogY1x;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WOH9pxMc
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFF131F387;
	Thu,  5 Nov 2026 11:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6CuA3OIZkZ8wIZVdUxFG/6XcKxuWeZ0VTf1oMbAQ6EY=;
	b=EtiogY1xV/vEbG7E/rOOexpBx9Ig7pstmgL0e6YX8MGNqrfmtwJnUYSogJpiogY2yX0hUk
	7JFyyLG8nq6ZNuGWGoc5GEvn06JZdQFt1/cxg/5zDl1lxLLy7wDeNrORCIpR1UxliABqMl
	qkp2SgH6c+jTmtL4F08+egqE1rVzNpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6CuA3OIZkZ8wIZVdUxFG/6XcKxuWeZ0VTf1oMbAQ6EY=;
	b=WOH9pxMcGJ0V4Hm2zyvZ7KX2gu9t+nKIGRMo6e+BnAsvSTgIQ/HOd31cOTZeayeCQA9KKw
	T/GCyoQZ4mH5VGBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EtiogY1x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WOH9pxMc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793877436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6CuA3OIZkZ8wIZVdUxFG/6XcKxuWeZ0VTf1oMbAQ6EY=;
	b=EtiogY1xV/vEbG7E/rOOexpBx9Ig7pstmgL0e6YX8MGNqrfmtwJnUYSogJpiogY2yX0hUk
	7JFyyLG8nq6ZNuGWGoc5GEvn06JZdQFt1/cxg/5zDl1lxLLy7wDeNrORCIpR1UxliABqMl
	qkp2SgH6c+jTmtL4F08+egqE1rVzNpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793877436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6CuA3OIZkZ8wIZVdUxFG/6XcKxuWeZ0VTf1oMbAQ6EY=;
	b=WOH9pxMcGJ0V4Hm2zyvZ7KX2gu9t+nKIGRMo6e+BnAsvSTgIQ/HOd31cOTZeayeCQA9KKw
	T/GCyoQZ4mH5VGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E68D134F4;
	Thu,  5 Nov 2026 11:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j89PKbpl7GruWwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Thu, 05 Nov 2026 11:17:14 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] initramfs_test: minor coverage improvements
Date: Thu,  5 Nov 2026 22:09:58 +1100
Message-ID: <20261105111654.214569-1-ddiss@suse.de>
X-Mailer: git-send-email 2.56.0
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
X-Rspamd-Queue-Id: AFF131F387
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -12.01

This series adds coverage for some initramfs unpack corner cases.

David Disseldorp (3):
      initramfs_test: drop dir data segment from PATH_MAX test
      initramfs_test: test unpack of dir with data segment
      initramfs_test: test clean_path collisions

 init/initramfs_test.c | 221 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 4 deletions(-)

