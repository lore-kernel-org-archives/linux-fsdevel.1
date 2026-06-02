Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3E91DF261
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780386089; cv=none; b=TakIPNBTtL8YuW0bpfH/LUMo23eco8JszgO3pEco3ljfmwGluZ6Ad/4Dcs81IFf/QR7M99TA01Ub3AD8/HgW8lBNNPBZWdKuSNMpzzsvVMIvxnW4wolLZbgNhjTwGMk/8Wiq0J/kkhWq9BR9iKz/Qg5DOOZB1o4kg0i8Pxamby8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780386089; c=relaxed/simple;
	bh=hdXO8WuR7pUtzv/OIIHSfMC58eYHVazvmWeQk/XoI4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0EDo1wOtkREN68XksB+4qGCjvgaY2+aGBvpGJ0p2SnluCGlHh4V0WS3dow6BbbAuwo5rjNzlHS+jX6jwvsSCLvhheDVZHQp0yny/EvILXHJvQVzX0M6PJM/OBZuOZt4RDcr7mDO0R0hY1YHcFaTbLH/SUhugAZRfOXOZ3cC7IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhM0a85p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhM0a85p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7A61F0089C
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 07:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780386088;
	bh=hA0FiCS9ooS+oM4XlD7bN1EhAH0gqUkn755Mz94STBs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FhM0a85p+gIXj9KgvgpHkigcX58gKxbBzJMNnNCfCHyVa8r4n8IbngY9gj2EcaJWB
	 EwervNfguOaq2ZXJ6BXlkuG53PVexOPEZKw8cE3s2Vn1WDPPfr22bIJi6Bf6jVi7H6
	 9+i4DIrgwhexV60cWsUuwwQmTwnIO1d284klt0LQOLw4tn2JdtBJDoCiF7Z4iUyjj6
	 cVbXtklweXQ4CGKgDgIKJzTuJ82jJk6T/86qh+a+x1WLGR0nJyJdPcUZxZ43VTUDPu
	 6t9vShdEkGcnQGnvGvLn+5SdwE+jeAh7cDRrq/706N74uDex3yNz8oyfLH7WOOWb5M
	 o416Kd3C1WwHw==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so3242519a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 00:41:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+GhF8C0UNHBr+0ocmW+ZKlEI7gyue6/gAPSRlSWFPa7E1DlrPazknDR4+Qorj9NRp+Jyi0afLI18zi8+Ft@vger.kernel.org
X-Gm-Message-State: AOJu0YwNENZJm67PycBKbKbMayQ9lxc/zkchiJz+JAflTZpG9kcfwUxX
	nKQPdAuuOzcSxRyVjeiFgY0/NxX01tQR5r/HqKGAIwm+9jiQPKPY0yV2KouvUmYsuFqQ7hunwGR
	RpK9QZn+Tgy4EbdGy30D5OAEyEm5z0pk=
X-Received: by 2002:a05:6402:a50e:b0:66f:9f63:e537 with SMTP id
 4fb4d7f45d1cf-68c8cd220e3mr4074950a12.19.1780386087215; Tue, 02 Jun 2026
 00:41:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601192626.150804-1-willy@infradead.org> <20260601192626.150804-3-willy@infradead.org>
In-Reply-To: <20260601192626.150804-3-willy@infradead.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 2 Jun 2026 16:41:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_8sUxdRT82pGmu2xo9=wt2ub_Jd_9ecFgOmQhj2Od1KQ@mail.gmail.com>
X-Gm-Features: AVHnY4Lgnr6ZT-SFXiJYLCzGrX6QCpf3_RA7vIZl8mbRng2W9bM_b_JQnJeb2YY
Message-ID: <CAKYAXd_8sUxdRT82pGmu2xo9=wt2ub_Jd_9ecFgOmQhj2Od1KQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ntfs: Remove references to page->__folio_index
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>, Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:26=E2=80=AFAM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> Pages don't have indexes, folios have indexes.  Correct this in
> ntfs_read_compressed_block() and also remove a use of page->mapping
> while I'm in here.  Also convert the calls to unlock_page() and
> flush_dcache_page().
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 495e90fa3348 (ntfs: update attrib operations)
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!
