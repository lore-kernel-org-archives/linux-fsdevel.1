Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175803ED13B
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682997; cv=pass; b=JCOj7xAoCawPGCSVD2JlJJHnITkutGUw/hfqjTDsn4ljhvfR7y5AqBlZ689oVcyiuCcRY2jwAkW9G5PA3/7NU65eOH2KpzIKTMpiAn8EYtGFkmlD1Z4D06Aobn9DjPpkeO5IfiLSosIlDE+Hdt3r0ijjmBjMPYd6Tb7zrFSUde4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682997; c=relaxed/simple;
	bh=J6SyjgSH6kKttxlcaQY5Q56ih5xn1TTo0a++egsS52Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWdPPp0ZQ90pEnIM8hno9E41U0s7nfOuhRRHJfdnAA8G2vZ5w/Q1AT+QgQ83LoVNC0VP020oqsHvhY5GQcOfMtbKEx1NTCcH+uS4/px+8AvVObE+8NvfeEBYtQRsaTmV2+uPwiC8mLl1l9F1db8g6xC/zWTw4Dln9emiWowEA/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lswfejBb; arc=pass smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lswfejBb"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398beb616f5so36855a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 15:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789682995; cv=none;
        d=google.com; s=arc-20260327;
        b=SOdfhQ1yWHiRsAcDK291G1v8gevC013EqbCJa76uaEGi5yBM74sVpC3rh3HlFh7eMP
         aGfyBujS/msgn4wLJgBLDxc0QIGussmkChlx/cz2s8xwuNyevYfNYqw0VHKcmzDYISEw
         YJjEi/JcqKiT5JFF9eDA2JNyxmlan7ujgjYvO1+qFIp3JlkvfL4fn/v9uCX3L5dLZbqb
         qx/lQ/eIIymupISOYBwgm04s7PVpgYlBl9z2LgC1NdneaEmwFWVVng1cMvlrjMeI0OTE
         hxY+9P6A7Hj8wMxrMzE6cNNEkeY+Q5OrQW7aP4dOTtn2PJnPftfbeg4mQ30W4t9Gy56O
         eBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wQRtY5QKl9FkRvfYTUErV4Q5sEVG3iTso9QeFHxPq6U=;
        fh=GmKO5i/3MSqsnaVoVRddnxnEpTE1OG1y+Ak7v9FGSF4=;
        b=jUtxaPhi1AGBRnFqd4Rwa2BDdN9i9qEY/K9ySNmxk2TsiYA4lpgiMIzz7J1+60MLvL
         N2wmSQWkUXa3Ne/qi8FocRiMlONT2mrFsTfKECoOzdQauzFIEQx5TBpr4YQ/pgeLMlJx
         uP0sDm3XCO/4AyevOrqXgRwkR9VNij6LR+7J3v9OkLnVF4knb2gzB3FcSfJYc9B7Y6cX
         VkrHVN6aY5BNldMVEn8DGxuAgtMNYxDGc4BoLRGEg4OheJ6r35hhd9o0yu3YmLnJbKvn
         K4XELPYokXjaVQ5m3GdpSX4/Q5YDbhPN9nSxVRJa9+lSNKgeeS8sgPt9ZRjXqQ5NNUki
         ATSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789682995; x=1790287795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wQRtY5QKl9FkRvfYTUErV4Q5sEVG3iTso9QeFHxPq6U=;
        b=lswfejBbnFiro7zTvnv7ohsJkWJ7rkQ1ar3et/tAPsK7KCiI/9CXgArI/dsb9GWkUN
         VSTQAo1g+yFzRB4fjqbtjJ65hNPnRMAfD+XHLB1mb8sWHr9PcIVo1mls15WPx2ZrQbO4
         4xVmL/J7G0kXnneNoyXTLdPF80TGG4m03Url4JcYatOduQdzvKLUsP/7DQYqXPn7fNeb
         ZyDPOMdhIILHCL6/nCNgE9NkxpcYL6193RXoDeW27Z49FA81Y8B5lT5TDqjVaP5UVhob
         3Z81S4P+evxtrrBvnImQCgC2NoVLOYQR2BOm2TEYEr3sT8Q9ji3/6W3qqb6ffHF3InIC
         eiYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682995; x=1790287795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wQRtY5QKl9FkRvfYTUErV4Q5sEVG3iTso9QeFHxPq6U=;
        b=f6LetSn6YaiOgh7B1mQHpH7emMzxcqzzxgKrpwEQJq1KAucqx2WNcNO8DRLkhJYPve
         I+/yBKr9sEcINGOiNk5KD0JSfvVAAFlMg348cYPvKXld99WHKcL5BcDJDLPT6moHYC2n
         TgC2/BYTfEGrmXysdxeKNX/0xjgExAxfY+Tu11cGqgusS6b2BtH1hnwRqoR4aElaOq+J
         DDJXaRxd6Pj/J5jZn9wXzCwO4o14hZ0bLZxk7w55u0gF1LOU4ijldcsF+Lic1Yudm1T1
         ukGUPSEUp2fRVceudhbnkb4VIqBYBc7JcvRX7Nr46f8Ui3ixt2wKueEEEMmYFS0FwPPw
         GFyg==
X-Forwarded-Encrypted: i=1; AKwUvByvPQfQzAyUYmNySalccibSt6D0kYc+C4nqB8MIeP8BwF70eq3IBfElV5nKu2QZR6kp+5VVt1is4wDxWiYd@vger.kernel.org
X-Gm-Message-State: AFuF++nF47fB9BZeplEAWBasWt6OxO/kqw/C5MeeiNf7rYMXFfOmdVJP
	RWSLrb5B7QjGfIkcqTUzn64J2SDzcR0szr1Fdejc25NZ7780cmbV2warxEWvNL4ctq6CvyrhYRa
	f8WnQ67pnIBURPGdJxEyjilao9Hzyjr8=
X-Gm-Gg: AYBFou3j5Z0y3yIWQheUVZNdSeurL+8YXaVogZZbCbu5fB5dXQ37gLwnpN6tCu1njR8
	zqrU28+Z2xuAjmz3s+vTsce1kUlxgCYVg60CdRKdH4C5rOwvguPoIygO03vrxFiQ+db1Zk7A6KK
	90IpMlFZgmBEAR1uwuszOoWCews0kQelX2lUMazJQMS10FuvFGjRDUfGWUYyfkwsD5jJfB84TLf
	E3OLP2cjjod4U8WUMUQkLs8u7fmJ90e1gTedHJVdYXIxRhJN4+bj+NdS8PrIJ8KG1pAXb4Z3tBh
	9D4VZfMEIHoxn2rLRklF+XzUzRDaI2I64RT+0iO6Wj6rZFuo+OVyvdz30uRFa4K1wWYgtB0nWTT
	g06UBNccZSkDiZwSW69zRT0/t3C85lbHWHlHJA7UVowfdlYWSt2Tv
X-Received: by 2002:a17:90b:5143:b0:39b:5622:d645 with SMTP id
 98e67ed59e1d1-39e5513d689mr482743a91.0.1789682995305; Thu, 17 Sep 2026
 15:09:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915080255.48929-1-tasos.papagiannnis@gmail.com> <20260915080255.48929-3-tasos.papagiannnis@gmail.com>
In-Reply-To: <20260915080255.48929-3-tasos.papagiannnis@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 15:09:41 -0700
X-Gm-Features: AcwNN1WTXc_NwWK6MQi-iRZUsTUWGjz1v6pzQXRB3O-GWxbyeKhFKxC4Xn1Cz6w
Message-ID: <CAEf4BzbfScpCi+x+QTdLifbaXPOR=DJ-7nM7F-Lki7vzD9L4OA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/5] exec: Clear bprm->mm before dropping its reference
To: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>, brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@kernel.org, 
	akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, kpsingh@kernel.org, ljs@kernel.org, 
	matt@bobrowski.net, memxor@gmail.com, song@kernel.org, 
	sun.jian.kdev@gmail.com, utilityemal77@gmail.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:03=E2=80=AFAM Anastasios Papagiannis
<tasos.papagiannnis@gmail.com> wrote:
>
> Once mmput() drops the final reference to bprm->mm, the pointer must no
> longer remain accessible through struct linux_binprm.
>
> The successful exec path and the bprm initialization error path already
> clear bprm->mm when ownership is transferred or released. Do the same in
> free_bprm() before calling mmput().
>
> This is required for BPF kfuncs where bprm->mm is either NULL or points
> to a live mm_struct to ensure safe access.
>
> Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
> Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  fs/exec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>

Christian, you ok if we take this through bpf-next? ack?

> diff --git a/fs/exec.c b/fs/exec.c
> index 745f6eb5279e..4ddd403fd91c 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1456,9 +1456,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
>
>  static void free_bprm(struct linux_binprm *bprm)
>  {
> -       if (bprm->mm) {
> +       struct mm_struct *mm =3D bprm->mm;
> +
> +       if (mm) {
>                 acct_arg_size(bprm, 0);
> -               mmput(bprm->mm);
> +               bprm->mm =3D NULL;
> +               mmput(mm);
>         }
>         if (bprm->user_ns)
>                 put_user_ns(bprm->user_ns);
> --
> 2.55.0
>
