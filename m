Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF753ACA46
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777500425; cv=none; b=P6ALSHBamTdj7WXDx0Bh2KfuFXfey9aD4nkyh4AGUG514tMIS9cd5gwiW9AzyebMYAH+GP36I7UmYIGe0xGgZWbTBSLKYIb5WESt1QmUiCATjIm9XQkP3x3qKAlF2Dpt1cfGXaJCvLxSrnrtGtqICFjf+7HKWcQb5lA5TEV2aqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777500425; c=relaxed/simple;
	bh=QVsbUe/r9JxogfHv9+cvN8ghNOiB82fnHE6Y5gSuCsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZnARKBf9xqfB4zR1atUC1a8A4mPuXy7Oxw8oxGI63CI44HV4YT4hPLkDeGwRce6A2j5RRzWS1tIhjpuugxGXl90OhVQQKl9iKVgFQ5Sj9nFoteeRxlAU8PXC4dT+AI1mENwrN2i/73RbYnCW8IWbdIyltyowLi88gZsIu7C23Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+2y/3xf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+2y/3xf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82FDC4AF0C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 22:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777500424;
	bh=QVsbUe/r9JxogfHv9+cvN8ghNOiB82fnHE6Y5gSuCsY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h+2y/3xfV4xYOgcmybuCYmOUPN5RWI7MGgpAiXT5ssMnp12fggFJA+iI/2V6rw8gV
	 MZfpj4it520bWg0KZPSFT5WrtHdMlFQ9G0/dYQm/wHhguNDBlOSyOLezpHMxDBeGAt
	 e8KExUq87F/YgKqgYP4SvL9JASDMim7kpVg+LxZRgrP/uwFPcWPLHAJjTn4Qd8oqJ2
	 yGd8d3d20Jxh21olJnmT+s2hdlAtuNDq/rMw0rpxf353+fkOd3niBQjaTsAU7DuBDZ
	 2LE6UK5/apc2lAFAbRUO8KZIw645GXV7tVOUErWRVVTDolhgddKVGqZya4WUIjZE2L
	 wT0ZFotXEBjVQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8f97c626aaso45879066b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 15:07:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YyvORSZp/k7EZPrqVnSZLcs9Apw/06c2f0k3aLS6clok2sM4npr
	yYepByVuu8wQiK4J6HonroKHXJ7LsMzRxrHftalCopyu/8lguqRQAPVUsUKs34SsK9PEsFUi41j
	QCY707tJtCDwKTHITHsihKZZcjcDY1Vc=
X-Received: by 2002:a17:906:c113:b0:ba4:8288:b464 with SMTP id
 a640c23a62f3a-bbb68d11d4dmr1188966b.6.1777500423293; Wed, 29 Apr 2026
 15:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428013410.2025736-1-hyc.lee@gmail.com>
In-Reply-To: <20260428013410.2025736-1-hyc.lee@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 30 Apr 2026 07:06:50 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9vTxYkqibG4uLU1p3-iXMOKgEqYquh1BKdeS21ZE3gMA@mail.gmail.com>
X-Gm-Features: AVHnY4K-ta2VgCAVcITprLqMDNZIf-NeQL293jlWhBUswrsuZHR7bbYJ7wT-Tj4
Message-ID: <CAKYAXd9vTxYkqibG4uLU1p3-iXMOKgEqYquh1BKdeS21ZE3gMA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: drop nlink once for WIN32/DOS aliases
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheol.lee@lge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 11:04=E2=80=AFAM Hyunchul Lee <hyc.lee@gmail.com> w=
rote:
>
> NTFS could store a filename as paired WIN32 and
> DOS $FILE_NAME attributes for directories.
> But ntfs_delete() deleted both attributes for
> unlinking a directory, but it also called
> drop_nlink() for each attributes.
>
> This could trigger warnings when unlinking
> directories.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Applied it to #ntfs-next.
Thanks!
