Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB774FD275
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 12:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792066754; cv=none; b=T9eQGH45s9zvb4dbLx5MuG2/Inbdni6wWFxNvKYbynF1nwyAwvsWyCsiQ/kKDwS3a0beZD3HyqwMALbLlCA0k0cXlFiKuvPST9NjH0XEebTepKN2Q0w3nv7rdbcJowXGJadSQVm8fmIIQEX9IMHl41m6Spm/9P1Pkt/qRHPzV20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792066754; c=relaxed/simple;
	bh=pR+ZsPE/BAelWupFuHMCruhA+1GjAPIp291axGzUwWA=;
	h=Cc:Message-Id:Mime-Version:References:To:In-Reply-To:From:Subject:
	 Content-Type:Date; b=CPqH2FY+3Ag1b1l/vTQgcFrt2aisG30bW2hn9VyhFslD/APUqPHDuSygxJXajgVnfyPlecUwtG0tf0mS0b1YqnV8TnuTCj6mXkslv8ps+S/nf6THipGMLTb8MSLSirNFbq8PlJMVuUxV2wMNFGSUGua95DLWfo+O4eMc8cd+uVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VG+PLl+w; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VG+PLl+w"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1792066744; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pR+ZsPE/BAelWupFuHMCruhA+1GjAPIp291axGzUwWA=;
 b=VG+PLl+wPZaDDPMYPq6GkxYmKO4rNSzfOLsHrao2RDXa+4+k53dLu2UYnf9gyp2fTK2QdU
 Tn64X4BBxrbYniN1GhgIduuJYDU9d4njm6H2AvmGnU0XuOfTbqNs2Pt/GSVq6IrWyxWyXm
 CI+MkxfWi6BlQljNAkSrPqPjWK+HHSVA27xbgWXPfhuuOxykuXQsKOHN1LNqUfpNdlsCsQ
 VksMoK0AMe75t+QYbjp3E2/SrxjSUUzUeLbao/JRR4jm78EPARLKbXy3PWQ8+BITBBssta
 YMeZXmf8Esd8d2jIM0t3RkM8aryIP93oQk9NqS8Kkg2jfwd7/hlGVUR/G2Z4rw==
Cc: "Jia Zhu" <zhujia.zj@bytedance.com>, <amir73il@gmail.com>, 
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-mm@kvack.org>, "Shakeel Butt" <shakeel.butt@linux.dev>
Message-Id: <20261015121850.1448810-1-zhujia.zj@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1791452174.git.zhujia.zj@bytedance.com> <mzx4rhr7zqhza6qh7zefytrmcx547nh2bvopwtdnannhnjl7md@sm2kdibrorwb>
To: "Jan Kara" <jack@suse.cz>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7bit
In-Reply-To: <mzx4rhr7zqhza6qh7zefytrmcx547nh2bvopwtdnannhnjl7md@sm2kdibrorwb>
From: "Jia Zhu" <zhujia.zj@bytedance.com>
Subject: Re: [PATCH v2 0/2] fsnotify: drop SRCU across inotify event delivery
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 20:18:50 +0800
X-Lms-Return-Path: <lba+26ad0c4b6+135ea3+vger.kernel.org+zhujia.zj@bytedance.com>
X-Original-From: Jia Zhu <zhujia.zj@bytedance.com>

Hi Jan,

Agreed, addressing this in MM would solve the problem more generally.
I'm looking forward to Shakeel's work on this. Thanks for the review!

Thanks,
Jia
