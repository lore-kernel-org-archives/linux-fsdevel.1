Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFCA31F990
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485676; cv=none; b=f9PSlIg97tgeMbitjlVL8ic7M/qKiz0kmLmP3/A/AuVXQs8UbryE6rLak1bIJh31QMvdIfkONG/6FBhA8JYzV2RbWKuxKrIUq8MCIfAMwMnTUxA8/vDnR+bYuG/QgV0R4D/150zuYQbxzYMKhvYenlJiUthW27ITUVMGo62EiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485676; c=relaxed/simple;
	bh=xvunP+QgKoT5YeKhRTXmekiPiO/O4wHjm0MpotEVYPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqgyNBdB/4M5L70dnaRtOJzDDeGNVlJU4vPH01ImmKyGwzcArf6+K2nrxOTXr90HW3mPhXuylLCre935oeJLOzzFfEW8p1Tsd4mfWbhCgk7NWHq98PbtHP+xOFN3OsOf4XBs+E4hxrylSKEV5UuVj3OanBpPtP5eYc873Ztx4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VwgK4i0E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSmqgUTN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VwgK4i0E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cSmqgUTN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VwgK4i0E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSmqgUTN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VwgK4i0E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cSmqgUTN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B0BE5BD15;
	Wed, 29 Apr 2026 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777485673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=22CrtvaJP1t96S+6LM3K3HP8ruSHZOqtPHt/ayPf0HQ=;
	b=VwgK4i0ECljQiC3txy4D2xP4fhj0IYeEY0VOwYKYfg5cJAYpbnnbI7tgoPD019YZF7e64L
	+1hh59Gd1HPrLOwCGyRw4Q9LQiALe9Z4/ocNqW63ADXY38MHtDHCMt9zuXTz5Mib06AlR0
	GV2YhGg5qNEMNAWzkq7n50YItcNh+Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777485673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=22CrtvaJP1t96S+6LM3K3HP8ruSHZOqtPHt/ayPf0HQ=;
	b=cSmqgUTNd1p3N3PzNCylOvwVpjnxzv0SGV6V4loqFY92UpQ0+BZAjI9y061rGhw2JZqek+
	JM6ILtIB6wbpr5Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777485673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=22CrtvaJP1t96S+6LM3K3HP8ruSHZOqtPHt/ayPf0HQ=;
	b=VwgK4i0ECljQiC3txy4D2xP4fhj0IYeEY0VOwYKYfg5cJAYpbnnbI7tgoPD019YZF7e64L
	+1hh59Gd1HPrLOwCGyRw4Q9LQiALe9Z4/ocNqW63ADXY38MHtDHCMt9zuXTz5Mib06AlR0
	GV2YhGg5qNEMNAWzkq7n50YItcNh+Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777485673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=22CrtvaJP1t96S+6LM3K3HP8ruSHZOqtPHt/ayPf0HQ=;
	b=cSmqgUTNd1p3N3PzNCylOvwVpjnxzv0SGV6V4loqFY92UpQ0+BZAjI9y061rGhw2JZqek+
	JM6ILtIB6wbpr5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0267F593B0;
	Wed, 29 Apr 2026 18:01:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JGCUAGlH8mnQOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 29 Apr 2026 18:01:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE3EAA0B53; Wed, 29 Apr 2026 20:01:04 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH RFC 0/4] fs: Deferred inode reclaim
Date: Wed, 29 Apr 2026 20:00:50 +0200
Message-ID: <20260429174850.18223-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=729; i=jack@suse.cz; h=from:subject:message-id; bh=xvunP+QgKoT5YeKhRTXmekiPiO/O4wHjm0MpotEVYPs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBp8kdR+NLtRSLgO4grYtS868zysozthYSdcS0Kg zSjAPGEsluJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCafJHUQAKCRCcnaoHP2RA 2bbGB/9ExsX8BTOKg1aXOjSipav0wC6y6/Aob4MY6sLV18jLwVCkgJbEX3wwHZrdqpuAr8S/Zaw spHmYVHBbAHQrTj7aneL1Jp94Gl1Y7Ksl+WA8bRGdo5xIWWMysVgsd5NL3iWD0a3zOOYi610vpA y4lH6OJOr6LmVc1lVnb9iMlDMI+8gjt5eYgsQb2jTV8Z/bHE6VI6H+HbiGLP/tBqR4EQsLuI3fq Sm4RdW25erHVC6vgufiLyJNC1rMkzKnQGi3Q+ixOJdgzBV+FgatvmkaPGqCjBpEv1yV6/82aO1w sjvrKwPN0Q8bHZFgJWr9rL9cJIccjh+Xc7qHKoYSYVzokTbl
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hello,

here are patches implementing deferred inode reclaim to deal with MM warnings
due to GFP_NOFAIL allocations from reclaim paths. The patches are only very
lightly tested and are meant mainly as a starting point of discussion we are
going to have at LSF/MM/BPF summit (yay for conference driven development).

The first patch dealing with lazy timestamp updates is kind of standalone
as I've decided to handle that in writeback infrastructure instead but it is
also a case where we happen to do GFP_NOFAIL allocations from reclaim path.
There are obviously other filesystems that need similar treatment as ext4
but let's handle that once the infrastructure is settled.

Comments are welcome.

								Honza
