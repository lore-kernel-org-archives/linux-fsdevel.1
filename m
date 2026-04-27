Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C4F3B3BF1;
	Mon, 27 Apr 2026 09:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283725; cv=none; b=P7LIt2+IOMRaAne5UGORXEJoWAJadKricQJwh3YqJX36oY/Jj8JCncSMUyiosAyf2R3Jl6S5UyA3UCgJcfQIUQ+TH9xAgSP4UOthC56xsZuYtbvmODBQZTGyGOszPlYTFUx3gigIuZnpcd2BJ+WGqIDYAm0enjczDyXwEC3u8SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283725; c=relaxed/simple;
	bh=Gs3Vnh3wogGEbNVPT12d/5DdU9NgMe8QcrSMm2+1NSU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GGwS5NoEU3DKrq/MFI1FnQyBx4rID0f73CqosfNEMq/DAWu+m7Q4w+k1QGh2FzMBOM5ZNSOsBNL3ooP3fjnlDuoUVNJCd4/Cl91nKWNPRphTwWag+4BTSJcer5gCBcaKzHs3sWBjlJKnyXdleBwr25n3QDzSh+sLAhR2MlKumMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=W1Ozqvr4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="W1Ozqvr4"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8012441098
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1777283724; bh=3H+HsivATr1jIWTDCLVY7dWcY19tKhMTVWTxEh1TFk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=W1Ozqvr4HKBbuW43otfkbhzgme1bHA8fOGpHs6EL3DT24ihrpvOCxqI5fQMZZO8iG
	 xi+8e0p6rb8gMH/kDIlOQbvPGeZIvKUY5mSFgz90Fx42X6E3pA50/By+waQL542XXZ
	 zSyGHskh1o65bpQbokQVUQX7IdXhPEt606x/yrcGxyeRDE9t7a8D2xRTlzushhIWNC
	 Rl6NocP0QAx+9hDeqWPmQAu1DWqo9xNFtjO1LYoPo5JyKvToUayincR483KKypG4ka
	 hqSmmloQBV1QrD0u5AP9AI9b/T4apHsoSLK3TlWYRl4/PWTeiK/cMHdaTNeLyFypde
	 g2P2PTJVaS2Mw==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 8012441098;
	Mon, 27 Apr 2026 09:55:23 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, Baolin Liu
 <liubaolin12138@163.com>, skhan@linuxfoundation.org, cyphar@cyphar.com,
 vbabka@kernel.org, surenb@google.com
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v2 v2] Documentation: proc: fix section numbering in
 table of contents
In-Reply-To: <df3b6729-ed3b-42e3-9a8a-f77ebf827dd7@infradead.org>
References: <20260424090654.19229-1-liubaolin12138@163.com>
 <df3b6729-ed3b-42e3-9a8a-f77ebf827dd7@infradead.org>
Date: Mon, 27 Apr 2026 03:55:20 -0600
Message-ID: <87wlxspw1j.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 4/24/26 2:06 AM, Baolin Liu wrote:
>> From: Baolin Liu <liubaolin@kylinos.cn>
>> 
>> Commit e24ccaaf7ec4 ("block: remove last remaining traces of IDE
>> documentation") removed the IDE section but left its table of
>> contents entry behind.
>> Fix the stale entry and renumber the following sections.
>> 
>> Fixes: e24ccaaf7ec4 ("block: remove last remaining traces of IDE documentation")
>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
>
> LGTM.
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
>
> I note that the html-generated TOC is already correct;
> e.g., https://docs.kernel.org/filesystems/proc.html#networking-info-in-proc-net
> is already section 1.3.

There are advantages to having a computer do a job like that :)

I do really question the value of these manually maintained TOCs; they
are always going to be out of date.  But ...

> AFAICT, this TOC is for users/readers who use an editor or pager
> to read this file, but the patch is useful in that setting.

Others seem to disagree, so we keep them.

I've applied the patch, thanks.

jon
