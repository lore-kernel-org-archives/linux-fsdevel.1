Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.249
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794373496;
	b=RyoyUIU9vnG3DC+ve7dtCm+Chht7KT//IuvrkcI89gTEJFSV+xPB/3DRJt+OIkiCuqo2
	 BzwaaPUBHIcKcvCFV0v2/eRqBA6yC+cCr5QDWbzNTcKYmgAE9SooGmXPSN5RjFc68pCVx
	 YqEEA5UWKqvXkvCiH19/l9YXkKsWR0ALtY+WGjjWx7dZrBOTGJ9PFAACE2zK4Bcz/1lmr
	 1J9iG+U+n3+QObWCiQpssvRznhcwBbocLt3LTpPU+xgrEwvhdduNDEeDMKtIAsEz2TblN
	 w7MASAgog4lhmuhHlOkr4L1gFS4KOqmfFB3/dXARuc3+fCHa3vKP/ivoUlxv+atcL5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794373496;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pwMIDxN53Gun3ZvBT9NYWaY5uVP4q4+uRkem49Njcz4=;
	b=trHuD23mhDmnZGmtTokDboDlVss0aMNcf/Hmqv5D2fB1MKaTjU3OqgkkiLcJSJB6Jzc5
	 8tWtzJ1x8KTUREa6dFEXJ/iaIYbQTVnopclA27kWSqlxikpu5eQqDvGTltE9JJg5Dkkta
	 cJ7RQAJdt6AZijyqJNLcMfRz3ClVd1H0ZF5aFyetPvxks4GE1DK1rJbjXhtE0MG+eWL/Z
	 F6qttFd8BPHLaZrPFtK26GenDuEHujBw6tFzbSAxOBZ1oQwEtxwsuGWTY38dxiYzl6TPL
	 T9J70vmHFWBj4Ff6gUs//bl97xZlJtRwsEC51CavK7rf0ld02SuF8ef48YvG+IuGQSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="OJP/ambR";
	arc=none smtp.remote-ip=203.205.221.249
Received: from out203-205-221-249.mail.qq.com (out203-205-221-249.mail.qq.com [203.205.221.249])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4E606A31C;
	Wed, 11 Nov 2026 05:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07E4E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=OJP/ambR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794373485; bh=pwMIDxN53Gun3ZvBT9NYWaY5uVP4q4+uRkem49Njcz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OJP/ambRq+Oa4BevtAVf0sulcR6cj0EeO+ctmjh+WwCv16waujVbUrSZ/h+Wv0Owk
	 SiH/nj2/42a9AT7j/NIB655ViLe0Q07mPVGsqNMCcInYDIpeNiinB88qId1mNCW4tT
	 uRhVjRuK3BOkE33L9SatVb2YCaNb9mOpfgKh77Dw=
Received: from localhost.localdomain ([59.46.81.208])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 12AAE6E4; Wed, 11 Nov 2026 13:04:42 +0800
X-QQ-mid: xmsmtpt1794373482ts5pliwvs
Message-ID: <tencent_32BC406D847C30CF1A0A6C4122A73281C905@qq.com>
X-QQ-XMAILINFO: OVFdYp27KdlJVqJjhyMvLkSvFNiIzUNCrfxlqfj/H/CsPJL4GpGN2gafQ14YYi
	 Fx8yK4DcLoOgUWX8RZaIw8WoC7+e6eKT3Nwkr487uJaTP7slUemF6+1waw/RkmP+ggm0Ptv2Ygg6
	 nB4gxCMsI84nSpuCaj04F5RvsRvmC+AA4MxJUVqigCpSKyH8h3kjMzp/EFgaGYZKa0+2hFbNjAzN
	 nwfelOUco8IdJAgNEDwZFfNc1PHutXjV04tea8eUrQWKUX92TKl7yRaJS6JIZUU3x01Oa5fvJYru
	 fRnsIAve6KcGpAbPJ9wsUuRxPvWK06QJDfcAXTt5/scfUxDbpDPZHZNOhdH5s+e7C+cJPhYz7hR1
	 LT9kVYTaygT86eNGWdyYCAsMrw1l69gNqVo1aAS9cCl+DvGl4xmLnDrydqM77bsKAOqP9zEI74Y5
	 OWPzCWiFF/Yk4MmQCnVcXgQOTZBGceEwkURZiZv1xZgX/BG290YTaUvm6sH6VHkUNfIHVohc4lfQ
	 A7rga1yIT2h3at2ZIqc3gwmEJLwFbVtZFUy3KOjhtMdOAXZ9pcTfA0sZ9ud8coR5pygwwoBT48ka
	 5KU+uFbb1of6/ZLMTCXEiNiZE4TUVGYEw7QXu8lGte2t2LMJcPWeSwn1SAiEM9TQQ8lBMJpKSB24
	 d4i1Gmo/lXsH8ympKjbhKq2CUUvD6TiC4+RcY+YNBzFUGf6bVDWItt5xcrvAuocvmURqnXTB2u3v
	 T9ss5wtu5z76LAkRc4M0UW7YvNP7TvvQGRXg1OmQNp2df10Lac79P66DEheKyEx/D8kWXe8UBZxk
	 Vz2o1wYwlx7Hn75jLjeGmGLar0msbOkgS9jis9lUfQlJHeRaePJW2q4SklZJ0+oKQOplxQpSp8mf
	 5MNTZUGDlh/E6B3K6TSdVUmO4YC9PEssOU4yPYHCEDDz2KTEgWgSTr1lQymrL7MQPOHWP8JNb9I1
	 6y5rqe7IgXaLjpFNiVlfEUs8qVOeKKJ8AICexUj7HYS7QHK8UejOMzvHqPQ0kxTv4jONvrAxWOsh
	 y68hjsriEnoA+A7IKkDh1onPApcZRI1CG8PvLMSg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Lei Qiu <750592120@qq.com>
To: viro@zeniv.net,
	brauner@kernel.org
Cc: Lei Qiu <750592120@qq.com>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/libfs: add blank lines after declarations
Date: Wed, 11 Nov 2026 13:04:42 +0800
X-OQ-MSGID: <20261111050442.8932-1-750592120@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_056A9EE408796550EF0B9739470910E62F08@qq.com>
References: <tencent_056A9EE408796550EF0B9739470910E62F08@qq.com>
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

Hello,

Gentle ping on this patch. It's a trivial cleanup (no functional
changes) fixing checkpatch warnings in fs/libfs.c. It still applies
cleanly on top of the current vfs tree.

Thanks,
Lei Qiu

