Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C598A23395E
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 00:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075343; cv=none; b=TclJ2l37yv4GkWMEKL1G9tYnLQ/kuMHjBOWx7d4XnXL/9So2SpTHJjurpAgwjKTmee+r6X9i3rVZ4TprxXyVqJmSWKnHxLsjUuhFyYbgS6iygUTLWdnOgFECXXnfRah0bMaxqTz1bFcbZrZsscz7PlcR3gfa6nNhs6ySsZ9joCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075343; c=relaxed/simple;
	bh=/KpWhTRc+p3JoY+v340G4+jJl6bjp6YzhC6isGqGXNM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KkW65eP3yBEHyGD1Dbv4qimNBNKCQhCl+kl2VaEjh/8wMa3HCwQEvNs1+yppBS1Bq1+2b1oWk5olJP/q/NkTBGI69H6bGtCUHEII+mIbTfrRIZkHOjsgH0d1bk/q8smmo1Hl/Q7pp2Qwo6IYuROOU2yDsYNJqhbs96T5/NphCTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ehQzos3b; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehQzos3b"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38deea72eebso2823582a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 17:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784075337; x=1784680137; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4nfsPSoEu0xJfM3sfM8gGgAEUP6nwZ6n8ooDYgwCJHw=;
        b=ehQzos3bbePodh0PX53MF+TUN+dNl2UxBx6S+YYaHOD8puy7nbO2zQZwPGG5VEr1le
         JUERDhvBdKXViWjzq6t0+uuoPf5ciB2nBYLOVjToQxdlAtQXYpMmCpfmYT2ONoUWBAiF
         uGBxvBC2o3+TEBKSlEPh3AnO3p7p/xvRRMYDSsJ8SzOWPVkS/rYsKhpUCkBTDkWKZVw8
         JU/y5ZRRqcSxa7mZx/ORefBcNL/fUPE0mMgpKGpkn9EKW+g0O52wHojv8qEidNOkFMK8
         bQuYPpegBND5bDSV3YQaJdGnrEuzLalO4lrACaKo6edRpZxy1DV6E+TdU3gvFW3sMLDt
         zUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784075337; x=1784680137;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4nfsPSoEu0xJfM3sfM8gGgAEUP6nwZ6n8ooDYgwCJHw=;
        b=TdeB6SprM+N2PvPr7VX9ar0jFH6Kvx/IS78Tusyz/0W7rClxxW1G4MSUNoFhMDt73C
         I0uDJ85h0fHOwbRXZcy72fJjcwBbPQ/nP8hsHjtARX8vMDzW3x3tFp2Percv+OtE2OHu
         a04EyMKR52jKkbrjsh3MSfMpdvsxkJaB7BV3dFyRtkVK7hBjQcLFV6spiCAug3LsUKDG
         9OFvsEio4VysCdaCHR+kAPCwt2EnUqFKexYbpKW+ozcq22RZ9K439++zZtwXlqEq117a
         GkcggPrFR1b8e21iSFjhOd9Yl8mSVQxbQ3/JcfuCyZDtQHDZE4PWbTt5MIeFKR5AgYTF
         VU2w==
X-Forwarded-Encrypted: i=1; AHgh+Rpbttq5HFn9U8Iv1FkniZcTW7FCsuiw+d0SQ7WVocXUYxY+YjzHkAORr1MMgrGr/Qf6hPLPHfMFWGyHcx1R@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwie3zgB2RqjprFIHoldiL6snmZ/dZu18GWcnDv+HaPoRbiIj
	86vNfJ09wSjFBTDNe/vsk4w1tObEweGVQdkDkoOvpHRicYx9ns4uWMO3
X-Gm-Gg: AfdE7cmojOlbkZHWzgZo0W0Lu4kBYoMuo0QN+cayGflLWCXrtmvnrcOETO8DDVlYyW1
	97hsosEk/5C6eeRRQolrfrMbk0X9HENE9O4NDwYAkOPyy6hEzGTqHmQ0sB2nkg1LYemt9Ci7Ycg
	ZZwePXGKtEfHmMCOuRxkQbExhqJg5/46tZxQOy9utp5Q3SiLXgenP0NZ1NFYxa5EuPsyJ+QfBlW
	iR66c1lAMETvxl+EpZtvCbbU0Uh3QDduzPJy9T2Ifg9+I0HdksmoOIb6CTD6wQB4VY6dAsPOZlf
	ADYXheRpltUxxzBc0fScgNhE/ghCpH3DdmivQeZTIWqD/p6uRt0cfW4krjoJ/i2rEUzshKwiQv8
	TpNeh1OGa719x20284WKedBF2tMqqDlY6TLngD405GIF/2HjFy0A0Dxzxlw6C3hBkVdrn5SS0bY
	GT+q6l6QMXDejxEWU+
X-Received: by 2002:a17:90b:258c:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-38e29fe2241mr708416a91.16.1784075337235;
        Tue, 14 Jul 2026 17:28:57 -0700 (PDT)
Received: from [127.0.0.2] ([98.35.8.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm86075098eec.18.2026.07.14.17.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 17:28:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 5/9] bpf: allow fs kfuncs for binfmt_misc_ops
 programs
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260714-work-bpf-binfmt_misc-v2-5-57b7529c002c@kernel.org>
References: <20260714-work-bpf-binfmt_misc-v2-0-57b7529c002c@kernel.org>
 <20260714-work-bpf-binfmt_misc-v2-5-57b7529c002c@kernel.org>
Date: Tue, 14 Jul 2026 17:28:38 -0700
Message-Id: <178407531871.2243172.8952621667118278231.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 14 Jul 2026 21:58:10 +0200, Christian Brauner <brauner@kernel.org> wrote:
> The fs kfuncs are currently exclusive to LSM programs. A binfmt_misc
> handler needs a subset of them to do anything interesting: computing an
> interpreter relative to the binary's location wants bpf_path_d_path()
> on bprm->file->f_path from the load program, and matching on per-binary
> metadata wants bpf_get_file_xattr() and friends right from the match
> program.
> 
> [...]

Reviewed-by: Farid Zakaria <farid.m.zakaria@gmail.com>

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
