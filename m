Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20D4014BB
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785408174; cv=none; b=gNSvLYjDC/IIGtEndBfHycZRArtx8uyaQKXRkyDJ3zQPyc09nRoWK7d7XA2nj1Jk8+/y/GYAKAELwmSfF5AMt7jA5ZQncPK0v9oxS4emiC3VuWVmtTzONtw7lbj+N6QVTzqvzxuyei78BB8DFU65nat6ui9Iy5yzrzijmXxIqTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785408174; c=relaxed/simple;
	bh=5AX3eFT/QWGzzIBO+WLTH1tym7uPsgE6Vuf2p7nHv4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hhrINZZlNGhqDY69DfM80q62Qxg+g04poI7kX87NoSuHxMcFscemumCkRgo+kpp7vAZmMn2GWc8UHjEDmkFJVz1s7Bk85hvmtIjaCcxn/8pvGkVCaXr4iW7T5wR8OXOi/eSNF0B5jOiGc/cbcGxO7tCNfQjujcr+GuFjIH2CeUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IPuyWhqo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TbCc+E/z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=el5qHxgU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fDokM/IP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IPuyWhqo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TbCc+E/z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="el5qHxgU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fDokM/IP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5FFC73FDF;
	Thu, 30 Jul 2026 10:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785408164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SmghZd+D/vyPTfR9YVu44R7/u6nfVyj3nSoA6PaUDmE=;
	b=IPuyWhqowDYUl5zZSv/Ld1m7NWCyOQWVdPhOz93VvrGyuMOUOeEhQ/bPHwf0ZfDSA4mmRq
	MR1DydfaoIlJJv0pfO2VcaZqADnRiBoX9htbvEv+Y2uM93pXebAHag1IWHogklgoJJCR6h
	CS1DElsKSnkrQhuKu5L2y4Cza+jvvRY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785408164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SmghZd+D/vyPTfR9YVu44R7/u6nfVyj3nSoA6PaUDmE=;
	b=TbCc+E/z8rfDOZZGl4f9Nai5AI2/qqVet/05/zgiUquHIFfPSn8vG87mW+9sSevbxrxTOx
	lJoYWwkZDEnI7mBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785408160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SmghZd+D/vyPTfR9YVu44R7/u6nfVyj3nSoA6PaUDmE=;
	b=el5qHxgUUxZmtQCAR/yYwoTI7Iygk20pO7tosDGz2Ed9ohUL1b7srZeQ91sMNdRDCrts9n
	9CdjXkWRmduH3YiXz8IicozSHJhXeDdLqzR7AxxKIkLc45oS/CBZbp9TGDOjfc56AQWbYT
	6XC5eqKChoozNWaeXLvx0aukiwmzDfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785408160;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=SmghZd+D/vyPTfR9YVu44R7/u6nfVyj3nSoA6PaUDmE=;
	b=fDokM/IPIfA1iD6W1ECikTzVjrAP7ZDgRoToAfM9dia4jfNq/BHXsPRQ7dAz7llWmIZKTi
	R1B7FPRk8I6oLNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57B56779CC;
	Thu, 30 Jul 2026 10:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pm1nFaAqa2p7PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Jul 2026 10:42:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02D83A0AAA; Thu, 30 Jul 2026 12:42:35 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 0/2 v2] udf: Fix data loss when converting inline inodes to out of line
Date: Thu, 30 Jul 2026 12:42:27 +0200
Message-ID: <20260730104040.18150-1-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=223; i=jack@suse.cz; h=from:subject:message-id; bh=5AX3eFT/QWGzzIBO+WLTH1tym7uPsgE6Vuf2p7nHv4Y=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBqayqTkSOLAxyD8ffnzBOJ9qEdKFfQMI2rhMf1Z I3nKdO0R7qJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCamsqkwAKCRCcnaoHP2RA 2f2DCAC12lyfKIcP0Fh5Kq2YIshgwcdRTYslqS6541Nif9VYrG9GUfPXulecAwpZ/GtImd7f3II 52/C4SlY1xPVHtjPkHo5gyX190xWA0nULm1xv6B31tihTWQuaQjy10/r7hg/uBF9/t3AOeU1xYb 7osO5ucmFkf+/BXP2kt9josP+x9jCIu73BfU2+AM/Zo2sd3aAdkMsHrCeAeTU8wKlkXoMsgus5g DAt99ZBg9ISghXSaXklH1xdp7UYEp6VIGBDejU6rgGRcax+KBKvzrs2Z/+3DbXIRtALfcYLdQvt rg25rwpu1KnnN2VAiY5jdRqYDbC9ivFOXSaQFOE0FfXcOMoD
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]

Hello,

this patch series fixes a possible data loss in UDF when converting inodes from
inline format to out of line format. More details in patch 2/2. I plan to merge
this series through my tree.



								Honza
