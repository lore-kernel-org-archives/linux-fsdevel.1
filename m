Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416B3112BD
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 07:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484170; cv=none; b=p7nPIrZQqfUcBIllRG/qMVVRQZ7GwmaWvCkNS8orjYeBppIOx56qtT0TyeC8ApO8K2m2Gb2zWIMkTlJGRGpJCzPvuUaFbCzXPltweekG9neVHMVhuOigT9dvBRb+V2vCN0FYEngm+xbvgYscm3dxtVP9/nQha9Mv+JVr7e1gZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484170; c=relaxed/simple;
	bh=RMM+ab0E5sCIfGo/3AVcTbOESRdP9wZ0uA064NM5n60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vd8DpB08hFWRsHk9KnBBICEpFOL8TGRxOyT2eydW7SR4BevVXwoBygCJ1svf4Tm84wtzD7HcbCHkKdNPXgYBPlBbi6lBOhfYxNZzG0jEqdLtQI7AqRoJe5Ol+/QXH4s+IQ/j8jNNMYFTmq6f6r/nL0eDw92cvykOeIQ9niCMfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pkYXoGL1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pkYXoGL1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=iuL4vbZe1FXj8BZwEKQAgyQ8NcFV2PVfzpoLKoU+ydM=; b=pkYXoGL1EK6L6hU7+3gX0e++/z
	bcK9BPs7oNEtDrkqC6Hso1a1OievGHslsLDc+Vsd4/LosHTHr3ypBhCvTnYYtPZh0VlyR+Q/Lq5M4
	Usa71ocaexB3tsWfYgCk5WI1NJ+jXZPvxMjUQkYtdV5B+aWjIUBQMnQhUO7D8LK+LIapUK5vODoKA
	VDoSome242CeKbbg8YT4/gX+OY71jqiW+CqhMg1a321k8xgnx/iKMylBlbTJwEjL0hvAdxSCoH2j6
	jJTuyrBVZJ3GqeDHwRJifl7Sjk54qIJ9c0F4qZFSd2J7gBrRHG1RPwippex9av8CGW62v4i5AF6WR
	cO9hDD1w==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKyQ-0000000CaiO-2G6b;
	Mon, 11 May 2026 07:22:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: drop unused VFS exports
Date: Mon, 11 May 2026 09:22:27 +0200
Message-ID: <20260511072239.2456725-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series drops a little dead code from the VFS.

Diffstat:
 Documentation/filesystems/porting.rst |    1 -
 fs/namei.c                            |   22 ++++------------------
 fs/super.c                            |    1 -
 include/linux/namei.h                 |    1 -
 4 files changed, 4 insertions(+), 21 deletions(-)
