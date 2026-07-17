Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9E35B632
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280212; cv=pass; b=m2+l0TctyKaQ1m7GU+3IQOJDt7jvbxRXkMFJFtNgzzDkmlmb16BhG0AfK54L9m+C7r3KyTJoMmkMoarYdbApOCcL5ahTYN0doEjZ+MoU7VjNH5yVsnyZcb48lR+kw4TsFJRSw+87fJwd3O8gk2DP5kzENWVPQ6SwshKwFsUJ5co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280212; c=relaxed/simple;
	bh=q7JBw0uEvnl91KbJC16BE2MfGudrZKPy3nkNA2uDpLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQ+f95BpUAmg/wCVfStweblfyBSlbr/M7iErRqMxO5yAHBfRK6RWQ27iT+Fle2v4/VFwx66+lqY4IcieZbux2Ygu3ziwgtxQwAm9ill9ainvsCkUIDKryKKc+jd35qIf0eWskApNtFuiYba92WoM3OapslraA+ZYXMPoDR5esbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRcQHNkV; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRcQHNkV"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39da69c5ba3so35132821fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 02:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784280209; cv=none;
        d=google.com; s=arc-20260327;
        b=hDAVcqzc8zqBEb+WHCA+3SysjRGtL+/LWp0mTEUjErQi6hBz2sFN9c/v/rJ7rpSJZz
         dtolJlIPH3wJW9JVVRcCkUBIJCPTA9sodRUVbu0o84O0TpWxsbPqwS624LWOCzH83oqR
         QzREXTIjYdzezz0ll9p90y19IPQRpiKNuagYT64JgVWRFStgJ2nRp4lwaxYBnauKA+qt
         8w1n/EGaWh66pFdBFkiCx38yRT/LVGSUJ4bxNvKTBnCf6UCz2XxmYJowHqlCFuV9EaoI
         1epVMfzGSWXE85c99nyLX/0vd87Ew4KBL/iN7jHQZDA6Dt1lQLBbPF1unDTm5TgykN+6
         u/Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UdYEp7IgdrnDTO/NazrKnZQNu44p7blCaLj+RUb2kxM=;
        fh=T3IqnBpXyWUycLP09Mmf+7JFmWXNeajXy9d5sFlQ2h4=;
        b=fmV7ulJDJ5inSSMOMDrA0opY7DqrUn3AmCDu2vmfu+I5R8pYUZclLjlsTqgYrKd5x4
         xp19h4/OsBTvQll9Ro1AGVvyXp0qRwtoaGarCmnJiftKpZ5vB5T6f1OLUxcKUEDAujkX
         P9FXkO9oRmLwjGSHup8ArscikK+fuy6OPm+2ohXO3Myb0qLtJOgayZMbxHlTGBACi/94
         eSkDh4uRGVRZktcwUONRWX4IS0sIBL5IApcREy56/OqVuboGgMbyjAXTFMM9gYB7/diF
         uUv4QDQ4e0/tR11JITZfYUepMtLXYBwsIR+qnoSJgO8TlDU5MHpIY42s+Ad1AHiHyHgj
         kvBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784280209; x=1784885009; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UdYEp7IgdrnDTO/NazrKnZQNu44p7blCaLj+RUb2kxM=;
        b=qRcQHNkVy+PKbEE64Qo14CeubvthvrHJuAZ98d98xRdPAWqYtHY7bbwqHnkj6OQVgJ
         hh1b/2O7xOzZqDLDsI9TeFacojlKEjnGFM/ETP7IXFL+s7HRc7ACv1fAbz9qZym6XkLE
         N+H6hO9he6qcQuCKP8PQDbUVE3xLdeuA2D/6/JcDTI+gqsegGlJdvbFUaDegtfP41iTr
         2k82YWPj2dKpEw/YBVxiG88Qt1SHDJ5yE4ISWExJ6HH544K8KJ9/8L6X+QIuNMEmli4T
         +CXJ6lutOjWwQ+W2MxWB4uOgWOaRO2iFOwWMRkIakX3IFVioE3oO0ApuGic4JnZKdaCT
         0H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784280209; x=1784885009;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UdYEp7IgdrnDTO/NazrKnZQNu44p7blCaLj+RUb2kxM=;
        b=XnOmQKo3ZqAhurHRD8sAlaS2dZd19zsJt76OFHzyrfwkyHkTw1JQXFIG9wpnU+tX6b
         898apHYNQ8H93tEI/6q6a4d5lHIf9fVY7pcWnxK7VGY/da0wyQx+p9MzBAEaTtevJguW
         +S41jgOiGdGDnR1NTkZZBr9YGpAWwxDhfd8U7vY/FeY0Zi/r2cEmd7DeJxyo83DvRqTH
         COh2qn/NohJYDaE+3V/Ys6RvCng2OOrQdgZY4OtDVZHGKfxqcMeYP8kTd9UnUNuZCyPs
         drCvBrg8W6+LLW8dw9PTV95nG8xvMkVujf67HDS+GIykULG/gMaTSF7vjIN5iZMCOwCe
         BlRA==
X-Forwarded-Encrypted: i=1; AHgh+RqlBpNTa9uhDdzEp4y2cJ3b8erUrQVU3GPFRSL5KpwJdqoNNDbcwnhBviSiA/TTcz9mNfnQEF55LZytAQu/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4LRD6epgmn1CgIqi6eD17a8YXdBMoS7cQpYzfo3J670MiVR2n
	F2SBZgj4VOS9q5Y1o/ZICsjowg6LrXIUWrJzMZfBjZrZwB6WaocpOOn1hEL6MhPuSmmf6mYvyZ6
	ODVhHmqjdGUiF0SbFCvXBbJEc52gQxYs=
X-Gm-Gg: AfdE7cmSNbA+cUcLacW3QEiJ/2yV2JfTR+I0ekLf0YydciY75wr52y0fEsIV2R7pJMu
	c4k7sT2APiKCWywr45Vzdz7BhEgySFXeoRE3tDQNWSyPoUIrz1HY5hu3PChlrLqcf0yNii86l2+
	W0cPGYkzYE2DaeDrD3tmHBajhj9tLVVv6WJ03voj7TmLUqfyVPpibUxEQ+9jGgGzs1ztOWzgUtO
	srAMr/bVQCjXiKZFk0okENlELxovZttoqvgrqPpEhj3iv8tbwtc0pWjCxMb
X-Received: by 2002:ac2:5694:0:b0:5b0:129c:ed85 with SMTP id
 2adb3069b0e04-5b28f873297mr471822e87.1.1784280208453; Fri, 17 Jul 2026
 02:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANGjgdm=gbQj=tmakUipHz9wR-mUvMVECfvJbTm=sEufxOe20g@mail.gmail.com>
 <q6pq2txjkc4hkdgo23s7t34l76rjsvbyebthqcawjq2dz6aiv4@rfygllbnj77r>
In-Reply-To: <q6pq2txjkc4hkdgo23s7t34l76rjsvbyebthqcawjq2dz6aiv4@rfygllbnj77r>
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Fri, 17 Jul 2026 17:23:15 +0800
X-Gm-Features: AUfX_mwpGWTOQ8hHUrNz1gqIIfio6WYyPgeJEKFzM9rpU_I0ynjrm9t8HoavJ4M
Message-ID: <CANGjgdmFOfskMaFhqC5uRFksioLoRvwFqg_P_d8qfhOKON9tZg@mail.gmail.com>
Subject: Re: [REGRESSION] tmpfs: flistxattr(fd) small-list slowdown after
 simple_xattrs rhashtable conversion
To: Jan Kara <jack@suse.cz>
Cc: Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Honza,

Sorry for the delayed reply.

Thanks for pointing me to this. The released-kernel point in my original
report was Linux 7.1.0 (uname -r: 7.1.0-bm-7.1).

I have now tested this on bare metal, and I can no longer observe the slowdown
after 1e7cd8a53b72 ("simpe_xattr: use per-sb cache").

I used the following test order, with a fresh boot for each point:

  7.0.14 A -> 7.1.3 -> 076e5cef28e2 parent A ->
  1e7cd8a53b72 child -> 076e5cef28e2 parent B -> 7.0.14 B

The 076e and 1e7 kernels are the exact direct parent/child pair. The v7.1.3
point also does not contain 1e7; I included it as an updated check of the 7.1
stable line, not as the patched kernel.

The workload was the same narrow tmpfs case from my report: one user xattr and
repeated flistxattr(fd, buffer, 8192). Each point had 3 warm-up rounds
followed by 15 measured rounds of 1,048,576 calls. The primary results in
ns/op (lower is better) were:

  point       mean ns/op
  7.0.14 A       218.202
  7.1.3          336.140
  parent A       327.037
  1e7 child      208.447
  parent B       323.640
  7.0.14 B       217.007

Using the midpoint of each pair of surrounding controls:

  7.1.3 vs 7.0 midpoint:        +54.47%
  076e parent vs 7.0 midpoint:  +49.51%
  1e7 child vs parent midpoint: -35.93%
  1e7 child vs 7.0 midpoint:     -4.21%

The two 7.0 controls drifted by -0.55%, and the two parent controls by -1.04%.
All 90 measured rows passed the semantic checks, with the expected returned
length and no unexpected results. Dropping the first measured round from every
point produced essentially the same deltas.

The machine was an Intel Core i7-12700KF system with 32 GiB RAM. The benchmark
was pinned to P-core CPU 2, with both the scaling governor and
energy_performance_preference set to performance, Turbo disabled, and
preempt=none. The parent and child were built from the exact commits with the
same normalized config, GCC 15.2.0 toolchain, and Kbuild metadata.

So the answer to question 1 is no: after 1e7cd8a53b72 I do not see a remaining
slowdown relative to 7.0 in this workload. Since the condition in question 2
does not hold, I did not collect post-fix profiles. For this specific syscall
microbenchmark, the commit appears to fully address the reported regression. I
have not tested application-level impact or other filesystems and xattr-list
shapes.

The compact validation summary and CSVs are available here:

  https://github.com/lcf0399/linux-regression-evidence/tree/1dae4daafc8dc93bd081b7ab71756f864c36a0b0/tmpfs-flistxattr-small-list/fix-validation

Tested-by: Chengfeng Lin <lin2530632123@gmail.com>

Thanks,
Chengfeng
