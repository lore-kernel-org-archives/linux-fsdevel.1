Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00623A99F
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386058; cv=none; b=UMOo14S/X7eO0wJMj5cwtNQbAmI7p2GxvvipToNiMziuKsXCA40gl4Mo1M8WpdqtDP3aMNEmEpCkYv6FiN4FZZEMF+OeF2eBQd233P20K+YxHxqS3AMuq0UlS0mo2gqtiJ5dRwQPsI26bLhUbN3jLiJmQD9HjC55tYkXDPxSaPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386058; c=relaxed/simple;
	bh=fYditk54Uku6bdeB4OKiDApuAv/ey2NvuAnoxzRJ+ac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O60MQd+F/IXqZlLSLKKLV8Y7V7qCHvo0GzI8Wz7qTuXTIqqzbzrzFcBjRQqTOH6eOPfOKz8lLIWMy3S4tUuCjaIhKIgvBXuSEWRXzmSBLBDlPiCF8Ea998CdEGPGfMKud57vh6cwzinG1YAhfZY1B5MyXZymVMQLQEtZwnSOVY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt4n/cit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt4n/cit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E384D1F0089C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386056;
	bh=fYditk54Uku6bdeB4OKiDApuAv/ey2NvuAnoxzRJ+ac=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Mt4n/cit0YTDOaHACOBbRmk0o34BjkWEM0CpWHEnL5PN43aCqwnmPlXvXFc0CU3rI
	 DsatfwC7+MfTYLARIcU537LstG7YH7keRHnF5aK+ANfAjqOC1r9JktihAggX8knOWE
	 wAiiHsgL0ZYd6SnRs4m6MWCoeprT9rHX1Yg5xGShRipGcuRKH41VL0R9WZp5DkS+6P
	 VzfJ9ruUe8ii//OL5HmIzKI6OleTYYloRY2HBNm2HheUZrYE4WQKmtPMpOx8SBOXdu
	 mythy3QXxECtzyQ7zTzds5ZOscPUdkajWGi+hIUVHm4sNFDK/1VCyD5z17s/MeNRjc
	 asLwezpzafofw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68c08bfe5afso2588861a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 00:40:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ80USrPclEsRPu2Ojs5unp0PBgYKL++E3ErcWF4Jo8kqnChdJNUvDoy6J5UoX2wcvYUbQ4/Rj7DOQwt6/cP@vger.kernel.org
X-Gm-Message-State: AOJu0YyjEPvErCCKoK0SPUIaaMeP7VxQlmDL/6HUQH2mYoeUWeRrWFL4
	MrZ20/ovXZTcUEq/TDenpf5o8BAeVKWuL0W28R+7/3+Ymlm3mf7EN6PPYyS67nhgmdIlO0awe0W
	LkumlR/GnTkFMYBAbbbXpyFNAf4ViJ5Q=
X-Received: by 2002:a17:906:fe01:b0:bdd:52ef:73e3 with SMTP id
 a640c23a62f3a-beab13c0e42mr869047966b.12.1780386055618; Tue, 02 Jun 2026
 00:40:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601192626.150804-1-willy@infradead.org> <20260601192626.150804-2-willy@infradead.org>
In-Reply-To: <20260601192626.150804-2-willy@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 2 Jun 2026 16:40:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8S6MCddYeebRajNEBrPDwLNC09=uWP5XmUaE15Gu+JZQ@mail.gmail.com>
X-Gm-Features: AVHnY4Kodk94p-MYFF8ymWKX7Seg-p_3ldHd0r1g_9SuP85Dgp63IRhmvVe9TNg
Message-ID: <CAKYAXd8S6MCddYeebRajNEBrPDwLNC09=uWP5XmUaE15Gu+JZQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ntfs: Correct use of folios in handle_bounds_compressed_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:26=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Inline zero_partial_compressed_page() into its one caller, remove accesse=
s
> to page->__folio_index, fix highmem (page_address() does not work with
> kmap_local()), switch to using zero_user_segment() which includes the
> call to flush_dcache_page().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 495e90fa3348 (ntfs: update attrib operations)
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
