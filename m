Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66123DBD48
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367951; cv=none; b=fjWP4p8ZDUIEFLT9Vp6dhxnTW902jqRvtGahKjg9xvpX0o+mFRL4R1gd/rVZeqAqLhDyRORh8oEOXYiWwsgbRUWxT5D+JZvxoKhkxIN999ZN1ivYfzNTuihrSTsnwbaS2Qm0D7abbSbXwhFjWIcWqFjIpjMan2Jzv+NM/46+7+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367951; c=relaxed/simple;
	bh=QlD3nPeGKYbXd7zeK8x6La0FUMv808+zuusS4pzcyYE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UjDNG/+h+kWpmZRnc83qOYeC/dx9IYdXqBIUDfxO0LCsB1VlG/aYAVHwnxoWUDAfbTc2n+YOXWSvH/1T6HLTSKV27MyxjYcS0wUzxWNlY/cwAgJ8ciLBr41en66IBZWl3e92zVBJ+7zz/CbEwuTFxU1XcBjgfzhP6KgIAvPvnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckZE4Gws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckZE4Gws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDAC1F000E9;
	Mon, 10 Aug 2026 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786367950;
	bh=55CYy1X48mpUWrsFfxjjXFMg/rvIGm2J087+sZKFdAQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=ckZE4Gws9ZQP6jAds2RVL4UpMgGTLgYcSGMFpBiNa05yhtoalSBf0DRXdzwi6a4Pt
	 QoCxoErU1MYm8O0wSsVBa945jUSF2foKMTr4P7w5C/dav0sGfGa+Uy6TN8qa97Syuh
	 yyAGQds9u8QWNEt3En1r/xH73Kd3VsYWBkIkSNf7/3SQtwrMc0tAq4JAZShiJV1PQx
	 k7U7Av7SGgtBa3xWoUdOy/H2wfp2Vn1LLO9sbEkoc7xmq8yDRaLCoeH4CX/5bajgum
	 92fa37vgGl3u+6GVQH4K671dlsGeA9Vlx1L1IpX//F4ZM7XXGKuqyxmn+7MHluDAaE
	 OjDNaslSPJ/UQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v6] erofs: accept source file descriptor via fsconfig
From: Christian Brauner <brauner@kernel.org>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, xiang@kernel.org, 
 linux-fsdevel@vger.kernel.org
In-Reply-To: <20260804055949.2927896-1-gscrivan@redhat.com>
References: <20260804055949.2927896-1-gscrivan@redhat.com>
Date: Mon, 10 Aug 2026 15:19:05 +0200
Message-Id: <20260810-abenteuer-mietvertrag-geraten-8f6a9fa6ef55@brauner>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=400; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QlD3nPeGKYbXd7zeK8x6La0FUMv808+zuusS4pzcyYE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRVnj/bOI3jYXTyhbWephErN/+323NutWtDSnKEbc99l
 qW/1zKu6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIz0ZGhvcGbxi/q83bq9vQ
 EHSh/S772kTWe3cevnn67TaTr6QOLzsjw6qsPYVHF6ZVf5tyIcjG9MfVt2pFq4zdM9hdhPXZ/gk
 wcAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hi Giuseppe,

On Tue, 04 Aug 2026 07:58:42 +0200, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> Allow userspace to pass an already-opened file descriptor as the mount
> source instead of a path string.  This is useful for tools that already
> hold an fd to the image, such as composefs reusing an existing erofs
> backing file.

Reviewed-by: Christian Brauner <brauner@kernel.org>

-- 

