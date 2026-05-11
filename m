Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4283FE67E
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778511265; cv=none; b=hCY8+S3RI/7Jo2bAEc1Pufc90NeMKP75GpE8f7KCV8edECvCOhqMt2LY4HLv4cDTrUd8Ivakg67JMyUYcP0r4AzRHNCXNiDrYUhYJJy79nvMJXAdehqYPYtC//FGJSpVCuAQ0Kz18phQ9W3tn3W1UKXfKXZI8KUoHZoDtQBITvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778511265; c=relaxed/simple;
	bh=gFsr2KWJ2DqTdnheo8y5w0wX9xCzEYSPKBu6yJtflO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swowd2dXhZkKOmRJGQUwAlM+eKQcUAzUKsxX3jlVgcUU8rtZyBflHRIbuBuDfIHF3KLGpxWbR03smpVZVa930C6/K2mrncDNaHfuCOG9zz83SgvYT6uknHIlTuDlJYiGvXDkBIW5UvMRRi+l1WaYMQshL67QNio6IiZt6qxj/3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBqctr6X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBqctr6X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697BBC2BCB0
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778511265;
	bh=gFsr2KWJ2DqTdnheo8y5w0wX9xCzEYSPKBu6yJtflO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cBqctr6X1UALUw4mcWQJs3a4QD7oM/k+qSy/gvEwnmZHirDjN+uu/n6PRJDtQ9oQ2
	 34YRINfhNL6QN5Jf/JOgbqCDKGQWQFi+1fKMnVRRF+W8hCKKi1L1PLq44UWqh//9yY
	 QOb1DSSzFOcJfrwclZDHSIHtYwTzJ27SL/VRuGm1YytlRGiNBwq75+fB3W2mCvxbwb
	 fC+ke3ecfJR/zTKPuOm6dyH29cKpLX1cZZ1zDEr4NGsL/wa0cQn2gU55PDWvTlEEf0
	 2UgODaq+yd1dGDPaqjNva+bJFYLHKgPbZHk9XZi6/T8Hyrq+wKfU3HQpWIAYmeKH0K
	 cYWc12dJqhlHQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67b6a6bd7b8so9119354a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 07:54:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ931200gdTMI3Mhy4xiacZo0jZFpkThQ5ZBwauzXBzrD8++dUBEAGSAeSNwAJeDG4lVD/PIFJFM37G2gvbw@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz1Cyiu0NB9tSP1lSUj4h+vVhKwk/bY+RSujxXbf5Vl4LEHuz2
	pKsqyOgMXgeOUngk519PpqRJyBmCmo12MXOSwLXblsuTeB3C1yooqg8jQt2iQhVyPO8ocQIAeWl
	yi56YkbhrG7LMWLwOeXt0/NJrHN8P7LY=
X-Received: by 2002:a05:6402:4252:10b0:67c:89f2:ae27 with SMTP id
 4fb4d7f45d1cf-67e0eab6c7cmr6306597a12.9.1778511259079; Mon, 11 May 2026
 07:54:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511095032.155854-3-thorsten.blum@linux.dev>
In-Reply-To: <20260511095032.155854-3-thorsten.blum@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 11 May 2026 23:54:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-da0GrpJOKDfbBrrw0QFdi0KtLb-hjUn5E2VKccuoEbQ@mail.gmail.com>
X-Gm-Features: AVHnY4Ir01wREuMkPGN9hcjV5Kn9aZ031AeX7_8irn9JdSEXmN89863G72MPcwI
Message-ID: <CAKYAXd-da0GrpJOKDfbBrrw0QFdi0KtLb-hjUn5E2VKccuoEbQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: use str_plural in ntfs_attr_make_non_resident
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 6:51=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Replace the manual ternary "s" pluralization with str_plural() to
> simplify the code.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Applied it to #ntfs-next.
Thanks!
