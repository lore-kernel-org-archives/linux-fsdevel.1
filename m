Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EF53CB8FC;
	Wed, 22 Jul 2026 07:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784704475; cv=none; b=Bbn5dhPUFoq0DdxTQ7dy1Turzd9Z2vlwK1VQku+pTwK2Jc+WFEtkQHHSU4ePTDV+8jam3EF3qtwFR9vpD7x3CkOQaef8Lem5lIpgvmPpZDi2Ob+JBvCLFHF6C6jE+tr7I6v+Gl036fgOqES2KE01CA2oCxPq6z8GvijPzNfZn9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784704475; c=relaxed/simple;
	bh=nvQsYh79rGuXa8maVjHlZncjXNNh7NI7FUyxAYrtCm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/GQK+/nE9TrwsE1b/bBbAEytRemURiaNQ2j6C69xEryj3Dpnzn2/DFffKlJGZuIWW+V0xUEqo82VxWmS3uigoAhOo9qh9OtQsCLnraf3G3f6Z9zFBfkujje9TL8dMZf9YNozc2vz5TxLFTlG98UVewQj0odwi0Q5jcC0R+llk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=JHjZS/bT; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="JHjZS/bT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1784704398;
	bh=nvQsYh79rGuXa8maVjHlZncjXNNh7NI7FUyxAYrtCm8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=JHjZS/bTMI9Hs9qNaBsu4Ku3oJK37ZImAqYoiTO8zzisWqWU34YnL9olOmlEWIUY6
	 G3c1FsR0MrECavhXScN+JPeUScjH0j7sbNhFhDeMg4n7lGvVmuKkEoy8pgJDGuJbZW
	 J1L6tQb3rNCVipaiM8ITaynqKQ46Y5HN+gqDTEkM=
X-QQ-mid: zesmtpsz7t1784704393t1c85d51e
X-QQ-Originating-IP: ObF75fN19pOYL0YiioBO9vCoersuNnaYnEYz+bost/g=
Received: from uniontech.com ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 22 Jul 2026 15:13:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13148559432894049444
EX-QQ-RecipientCnt: 6
From: Yichong Chen <chenyichong@uniontech.com>
To: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yichong Chen <chenyichong@uniontech.com>
Subject: Re: [PATCH] netfs: clear PG_private_2 on copy-to-cache append failure
Date: Wed, 22 Jul 2026 15:13:10 +0800
Message-Id: <20260722071310.18593-1-chenyichong@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260704050603.427472-1-chenyichong@uniontech.com>
References: <20260704050603.427472-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NyqG2qnv0b2dyDNMpKc1BiU4nI/l9bcAYrSQvYw6EXRM+zNzceLGJiO9
	IgsaFbJj4O4Yn/+nswCJA4q/mFBSLJYQp8LUMDo1yqU7np54pVUe+vo5EPnl82jBEBxp36P
	9EBlJnKZw8vweSEUxBMTsaW5wapDrbV0s8Rc5fpU/iTo2fIldh2i9DjIsALg/cHZfJlqgnb
	FY0fKFAAnS8dlwTAtvkrTicsBMjXVYimiv0cBUaKVVpKgPojbXJlKn0E7hCpiZ/Dgg4lpGX
	DiX6x7NTkJY+MBglJ6rBFBdbZyOnF3axbHTcxQSZnadB95Dh2GLZX93mbcr2eUDAS3Cotgv
	+9lIwD7kniydRvAfjOqa+IqDXUmnYe1msbm7cXVpsSwKN0fZ4yhgvXI9QdhWcyBqCc3Ru4G
	hAiQLVeJHWTGUnzk6aclF/19udaS/XxW1oOaDa6aD1Hh9aG16hltvRCQi6BuNGC6im3CCUt
	HG2gcch/OUji7zOOjdZUfIUmhlxqzmQbH5030MtTbuUVcy034nUdVUVglXUGvulkPR7rTnJ
	KlHd0L9uvfypslbNpwaYWwKhycPSrF94lF0lfkS4qcyy5HYzkxdnA8zISy7mZgvkrgD16Qw
	KGtaeQvKjNNnaDeEWX/B6Q79VkeEWEURqOdAWrfXOTE3jHF5LH+bvBOnk3NKREal6fOr/DH
	C1S32RwAHBJcMaazH7FcUb4fAvonJ+RFGioCdJ8QfjS0B1NjpBaxdYku9MCE2zRh4Is/9t/
	j5ik8aaDw+UZK3bhOVELRe9vvTtnop9gxSvdHLFd6j3td6Ps/smA5+GDBZHUF43m8xSszn2
	4MK8to8cm9HkwOoqNLAyHgr8qF0VczdWkPf0A6VLeXBs8/t6hr/XhpnntzfpyrCxU/6Dax6
	Y46Nyn/6yHOFGZ8RHcDluVTiHEH4ryN3mGHFU2UE53952sz6+LpS9m7wpei3GUnp4tGtYLQ
	+L1tpyMw2B1lMmFvi928mCJd9BPjTw6E4d1gI7+V0T/fy6tmHd/bUQq0rVzZ6NdNUgNjh+2
	3tT5+n1uBZJ0xXxcP4QzpvPmv9QdA=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Hi,

Ping. Any comments on this patch?

Thanks,
Yichong
