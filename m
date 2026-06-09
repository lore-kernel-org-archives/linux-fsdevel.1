Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2801633ADBF
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 05:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981614; cv=none; b=QEBbIKGFQA83U1BMjuGXL47a+lpalwhNxlx+grIKyclPRqH8WfZZV+Eu1g6kH0hTw5I27vrGJvljJJQzFxeGXt6wSujAo2g8tS6qBXnsZ3bxUFWCwHlYI9kCLyq0vF5z5yfpeqEqhd46hhiaopS80La7iIfzUybJJi6eUS6kMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981614; c=relaxed/simple;
	bh=1Sz0u2UAO5peDXeJ5+UPvZk+HnwlVnSIWkuhff2dIus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fF5lIZL6JJbZJJsvweS25Qiihk8KKCL7PbuY6nTb1EesE8d0WtuMXp+hrI50iA69fcEv+g9/ZKhGDxrN7IpdniZwC5kixcbzx8Qcsd5ZTqOfgf2DeDOYCyTVGXxFkdHHOliWIw4ZIi1Hf7pwcNjNOwUvW2dL6K2Ff/6dXabIfjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7odLtzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7odLtzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1251F00899
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 05:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780981611;
	bh=JSmZZXCHaEGGL/4nRb1w7Q3fqAEMLXnTrHJuHv8jMg4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=i7odLtzKyeWt4OfkJY2Dq5sKMbddv/Fs3b3USqUXnT4DQKHFhIm4SdMfnZqEnf4Mz
	 jMKu4vswewUyT0JrG7v4sCPtUvsKupUvnim4VsVugriYScyQ6FF75YUrtJK4WSDCXf
	 43BcNiIX++WNvKZDhEck14yVlpk9pIbTMpO/3x4cQayfwDdi3zzZZofIFu5hUxJbIU
	 WyTNVAjzLndL1obHdMAYHgDEcG46lqik0+OQHjisi47+y8twlWJroDRFZR32lJifbF
	 Xj8khn2dXcFc5D21r+jxytYKj13rodwvKHYazlE8dMdq/qSerdzp80jITmPuyqNBjZ
	 3FNEwLxfFWn/g==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so685780566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 22:06:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8E/GVFBQ6hEpHyPC7SbreqJ0iRNftBXCueQS2Cg7R1uaFmq9xfK23/HQphsrLZo/J+lhfnWMtv8R2jeljr@vger.kernel.org
X-Gm-Message-State: AOJu0YyivdrrAXj5OANMyoGsC+fJmiRB04VE4D9aSwpoSvI0Lk9/K9Jg
	4XzyZ+uFgONFYdLhGh1CYbm+AaHmgjBWVSYcPKe/+8xzxE1e0ZWm7WVts6+N+S2navkmQOB71kh
	jIgcl6wBXBMob85YEIwgRxlvOYpte9RA=
X-Received: by 2002:a17:906:dc8b:b0:bec:64c3:9ac0 with SMTP id
 a640c23a62f3a-bf371e4e3aamr904505366b.14.1780981610177; Mon, 08 Jun 2026
 22:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608210618.3437216-1-willy@infradead.org>
In-Reply-To: <20260608210618.3437216-1-willy@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 9 Jun 2026 14:06:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-JmegoqrNR-FyLgvBW3qzWK2FYSsNmxTY33Yi_qu3cqg@mail.gmail.com>
X-Gm-Features: AVVi8Cd3R2E9UIB9ys0n7A5gsqUoAl2XbQeWvqCvfsDFaTDj3QI7vviC7yYslZo
Message-ID: <CAKYAXd-JmegoqrNR-FyLgvBW3qzWK2FYSsNmxTY33Yi_qu3cqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Remove __folio_index again
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 6:06=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> I renamed page->index to page->__folio_index a year ago.  That proved to
> be insufficient to prevent people from using it, so take more extreme
> measures to make it inaccessible except through struct folio.
>
> v2:
>  - Split patch 1 into patches 1-3
>  - Remove inversion of the i_size condition
>  - Use page_offset() instead of page_pgoff()
>  - Preserve the call to flush_dcache_page() in all circumstances
>  - Use offset_in_page() instead of open-coding it
>  - Remove shadowing definition of struct folio in patch 4
>  - Delete the printing of page->index in show_page_info.py
>  - Unname the padding where folio stores index instead of trying to
>    create an unguessable name (Arnd)
>  - Justify removal of page->share in patch 6
>
> Matthew Wilcox (Oracle) (6):
>   ntfs: Inline zero_partial_compressed_page()
>   ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
>   ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
>   ntfs: Remove references to page->__folio_index
>   show_page_info: Remove printing of page index
>   mm: Remove __folio_index
For ntfs part,
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
