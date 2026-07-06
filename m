Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FED4436BE4
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362031; cv=pass; b=tQYyN2Bcc578aDVzRrcFuL0YrsmTEFI+AdE09hxn1GaaINHRANhhF9C1aPBPemvOL/F80PzcIPv7mQ3COEIVL3ESojSysC5ET8JA0z4cekh1dhJa2wvKK6R3TZYMHazSz25pTZWchEASe3OofRjd1T5C+XaKiY3ZO/+d3f+tC8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362031; c=relaxed/simple;
	bh=f2PHj9VJmtsIw6saatHDAWjezcUB7k/3fO2FNNUj+Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLTUgmH43TXTHUznKRC1LyBgR8LNtxErbHlSgPztU8UIJmVhTNqkDoh+2b4bM+Jp4I7ClACsmc6YuKqqr3mWNwpWe1K3YfgE9DTKUicS8Tj79+OSwwxpGOqAPrXYOiIHYeDOHcHNeBFqm/rX10RSUMi5hxmONsi0veJrxATF+ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=krnuY3oh; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="krnuY3oh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacd69a9c0so28364055ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 11:20:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783362029; cv=none;
        d=google.com; s=arc-20260327;
        b=ot5nj+pDffnmYvtS8WpPm/+oqeCt7HhK42HTwsnyMIw1Mb3jUY5wq1DqkBDc/zV3fE
         LvF+e6hNahZcAqcJ3JtOGf/U75yQRjEL4+ppf/2/oYM7vInpcyFVIq91UPcpn7MIlxjW
         DXyp6FNsNVWVdkJoM2u29HMZAUKzAkRde+tRqHLt+jsxpFOJkOojNsK3XGlUOB2t5/DG
         Jibm/6Fa3JQaP7KaueGplEQdyamxYABZvuEVoHDefnfp861YUsWX4/3YCpD5SLjFYdcu
         0SJX7S+8T61WIgOF/1oNLSaAsFKjaXp/HiBUFqOjcLZ9+a479bkNdf73TLuYrAAPizjI
         wYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2PHj9VJmtsIw6saatHDAWjezcUB7k/3fO2FNNUj+Hw=;
        fh=IVz/kHd4zfgsILBJnGlHFEwvOwS09CQowqJWWJTGvAA=;
        b=snBxVEmLPV+a33Shri/Nq9IUH7vi0XJc4hjQ81UxNHAiAx4GixMJXh5Qxbshrgq9Dv
         bCGwKpLTYBMyV9MkgAQ8REIDahp7lO2w9Fr4jgmSbVRoFgM6KC2gHvXW+FgA+Hyt1lOJ
         FXKripygi7l6E3PnXoQ832YoQNaMO09wubkBkR72Jmd/6C2n/c6he/+5N6nDwWYGso8G
         49EjQtFtjJYLTSmBQ4HtTpaIfp1zg0EIYmKkvDm9u/u0Fsy59ObNB2vdC3AIi/wvqVFY
         /TsqX8yioW1kaqCaziyZHfDoOEzwC+DyQZsQr+BAr6qnUpFLs9A3XQl77sGlfr/xh8qH
         Vh9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783362029; x=1783966829; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2PHj9VJmtsIw6saatHDAWjezcUB7k/3fO2FNNUj+Hw=;
        b=krnuY3oh5QnmUCQUxXBsjcMNQ0lc1ert6R/3TEzZ2A8DQ32+u+5avy5votP3U2+UxY
         ASQVGjmx/lzKkbPqiOxqJfr1MveOxah/3T+OU+g2WfV8eAyARTFRXIzEvGyv1a0cxxAo
         +wL6SlQ8Jdy8JDgMWTEiYSu+Zl4nn1MfdOnGHZa1F7k7w/XUfR/eGNngADh3e/vYVU7N
         5q8hXZVJOF0xcPK2YdT7Kr4mU72+8/bEXH1TX8W8WPWBK31g1D1B5BMnCzNX8GKqtC0l
         92VHYsCQqHMOE9Wz2m2U5l2WVKVFzKVGtN5FW5YcLeqhSGxTMpTpQOdCtZqfJvOTfvL8
         uh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362029; x=1783966829;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2PHj9VJmtsIw6saatHDAWjezcUB7k/3fO2FNNUj+Hw=;
        b=WPCO+s4/+IRcarjmUevZzSoOppJF/LF0WFtXDYDGdE10H3OfV43cleo9sabZOkK1z+
         j/Hk8koe9Nhb/06E1ARrqxVw9bqaxZiks9l9IVoqBMq+XvOt7VcH4fS257B1xJxdp4ja
         W1f9GIndtYs4pzvwf4iQpeO5j0BPyhCbjbnfxbRm9MM9/R6A7EYhzGW+tZlsYZ8SjCY/
         Tgm3Z4VrXUxLc5X36JxOphQO3Nef1HmClJMEvSBw7KRn5xDc4S8BO9a4vQtTwVXyer/b
         pZNABnceuiuKi/18NVDCc7SKTrTZ3k1cof5azB57UsoSOfVvSSj6uTEMTfR1I1CpRiwM
         iphA==
X-Forwarded-Encrypted: i=1; AHgh+Rqt4+SXYA7LvShmOTcWf1oC0/l+2ZnANfvN2QTdOIijGJhTF1U8ZAj1oJBhClkUgI/P04w4E4zZ3su1lqY2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/NF/WT3zhtuba2fR5fKXpy+Ht+c3uMSKmhDWLQrgSlvDDeBiI
	p6Jcx6z/9yP0L36TAVUzyzuPX9CCpF7YaT+cjPQxBf9IaN1MDA6y6McIBqgjV5Xa3KbtRYJyxR/
	ErEZXYB2DVSlnwbwAt+1NkwIiB7MjAKDtzvuPjrc0
X-Gm-Gg: AfdE7clZx/NX7McZG1z974ksqinwdqn+mRXV7j4pP8xKEskzBF3XxhBZ6Sk1UEhUZZx
	Oov+CmTpEVd5lYw1mJmEVLKkpkCQN26+tPZDvNrLvSgEOeSQ6vofuiFMTfIszTQJd18CfcDNleK
	Xd90jOHKEiZ9rgqhhPajxJ/w4/cucKeOU7i98xf7y2E47I8WguwrSigBUbzZvJyANpir6Kadk53
	UjIewGS8pW2xgEEDHlB1m3yTo9wL813gCVbrOV0k8ybJGfZ2P5kM6Lq647oyBUlPQHiZSJza7rd
	XJiqV20ipXIQSD2iaQkO6Cz9LivRmCaW8Npn9OXehSUognt/CcS/+OUBLGCT1eXug+j/AQJW+/P
	V3EtP34fEDgnEQ5Ng4Y38mkhpUMDJTOgGow1NpKQ=
X-Received: by 2002:a05:6a21:7116:b0:3bf:6c08:2b2f with SMTP id
 adf61e73a8af0-3c08efa611amr2088864637.55.1783362029050; Mon, 06 Jul 2026
 11:20:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705123826.3818443-1-jkoolstra@xs4all.nl> <20260705123826.3818443-2-jkoolstra@xs4all.nl>
In-Reply-To: <20260705123826.3818443-2-jkoolstra@xs4all.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 11:20:17 -0700
X-Gm-Features: AVVi8CcxohvHsY7AotTJutKD4Bx9caNjYENOm7GnE1Tqy2ObFIE98uM4BTIeXi8
Message-ID: <CAAVpQUAViuZ0DY_1=N_VGuzN7cBM+oFDKb_Fiik8Hb-ueQJpjQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/3] net: scm: move scm_detach_fds() from
 common path to scm_recv_unix()
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 5, 2026 at 5:37=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
> scm->fp can only be set when using UNIX sockets, therefore we should
> move it out of the common path __scm_recv_common() into
> scm_recv_unix().
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
