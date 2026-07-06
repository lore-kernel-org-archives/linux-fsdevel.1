Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970D3F0773
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783335939; cv=pass; b=jF12avywr5DanxcJ01CNwJiN8vIQxUXGpcRrydM6+BJgCxhXTSu0eIefQvb5G2X672vXg3+psvR2+x0UYFEtMYKRxUcDYk/Fi2rEide295sHRjwJVb97H+oEdLFtdkXJu4liqPrHKzHAcvJCRMx1DDWW4W/3+n+7CnTB9c378dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783335939; c=relaxed/simple;
	bh=/hNkRgqeQVbmzvlwRmP3/2RYGVe1oSFSJkX3H5Zcdt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtHcZORGZyIQp5kgxbeoVwUHTgwqrMtemvZJ3Cd5tk/gFWNHZNf51msaBIM8YShvtwDVXVuQD8nkKHMkqUgc67VEYabtb0okuyrGgT0D4DJf/C2KDTeHOcvRl2qcr7R7+zVA0VOT2LDSTwJrInj3BeYx+ObG0Phq7POOdoc0cts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=L7kbB6Wc; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="L7kbB6Wc"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfad59921so20618621cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 04:05:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783335936; cv=none;
        d=google.com; s=arc-20260327;
        b=sPa+d1/NzwhhnKcFBMkut7ZsEtLAb/cu4ZrE9uDxHgfq0F2tjTjNGV8zaFkz7kT4NW
         xL4fRlY8l7w1FagSwPorxNl9JkYjdJ9KHt0AAT/Hr2uRAOskhxTjdIGH+Aw232VhXSdL
         +c5mZlulX1g5w514czRr0/Ziq7SfzcrVSHatDi1RmdrsvTfCLSpNxSQGGBDML02XYVe7
         UzKD5NSGxLnJvYwfMx6fgAyxVlJ59rppw02mn5bXazAPyyjr3QOJhGNJIQUH4OgPJQcC
         l3PZjjF/gt2fGX8UqJaWjV6wJWAn7Q4k+BMDMXa6kf3CmQ6PUeV8YnQ4q8INFmgAABi2
         DVxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5N9xOz7IuFoWi/YP9UdZnMaOav6tflAjjK/V30R04Xw=;
        fh=kyofVaBzCGlOZvi5JbbkfFoGalBWIzTk7fjiQ/68yq0=;
        b=C+YnAz+30zo0Fyn2iYcjRuoPH/F6IUr+Xgbk9Y8nbKVCdxYW8i9rJlG0NQel2HQ4sq
         rQlpKu8ZB7fJ6Se6ANRw5JE9AQwW4yPqKo6JScg5e/ZYkXJm8o56hH2hKirg/Zwed9ts
         IO5nB0n+ghcwaXYDS+M4oDtKX0bB73CjJWk2sYCHr+OWpbl07GNVj3SfgQTN+4fdoXat
         4Gi0i2Ya2LiW/PKBYN8i5sHADlQv+JB8g13QHLsPQQupTaMFWluYcFAT9mnPOnkFziIG
         k/irH4rL/dcLYY47TY8HWCETt8pnvqWfxm/YS9yLtGOnUrygJL2h0aiqRHyXcIVEFMQ/
         HU3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1783335936; x=1783940736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5N9xOz7IuFoWi/YP9UdZnMaOav6tflAjjK/V30R04Xw=;
        b=L7kbB6WcHUV6HryxojFgeaun/MQ6kjrsBcAqV+yFpS2C9zHYxYE0AnI/mL+PM9VF44
         ur6rJteTLgKQNtRVXVv7dkrf8+W6qeFnqKNbE+nA/plr7sNWyKKOikW7n1UyVJ9+fttA
         W9tqDW2bVZXB4GuHXBbwsX1eIYoBWEokArOQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783335936; x=1783940736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5N9xOz7IuFoWi/YP9UdZnMaOav6tflAjjK/V30R04Xw=;
        b=Fy4UICifT0ANjT7u9RjPQGJ/3Vw0h3d1+dwFLG/Z4CK+bwVa4AOTN5PR2Lwv1H0TLA
         v1hvO/YSu/adJbNHOOmC8QnGpkN1+Ou1k0x1CdC8JvnyCfzltJ3MipkZcE9qavXgRS8d
         ctRCNDEzeY2Rubb02Uyb2b36uZw3PlkWz3VywBNxeMmuwZ8VXYnA35lk+hb2HfgACIRq
         qotkRw+85T4oivcd43jb2QCBi2DLO9cSZblo2LKxURPz0FsgHh6iMepByBxYq/Da5L3p
         oXDqFjq9WuVANDbzygqGMbatJU8TPAgVl3i18VJUasOyK3Z8o0DJyGeNBh7r9ENgQLG1
         L0lA==
X-Forwarded-Encrypted: i=1; AHgh+RoabjjXaZmtQ2Dkv9/pDKUBksqndR6n39hZpyc65GfEjnQnCAz7ao8mEIt5D3vsOMnv4OiNRufomC1a5bzl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx03y+en+MEdi5ff8BgcDEU+VamZyvvAgxqCYKx11gJGJuMNdg3
	784XfRGesY8MXk0onaz3ehE50VjUrq5oP0imBAd+NGgUdZCj3/gDoLVJFee74pcOKXyrBoXMD45
	FzrvKBuugfUfCDMbLgiLPRh+Dymlboa/gpx3YvpKuLA==
X-Gm-Gg: AfdE7clMu8BlEOPQgGPmM97kI0hRVTpURGM0Ejp3SuYQgpbc+IDg5MqeuMwuq0Hg9z3
	IRhhVGqpzwWeHjEMejCntwVhlhCv63eWr0KYHnXXsFiiZgi9CHs1oCjgdcMdr3ZU4Q0/hXGWPeC
	tjLvroGYxWDP4KlkoYU/QOs9DWrMUB/gaBdBPN40IX8ktRBdr5mtERyM31qxd2OKoNrKTmq6Anu
	8TEwh3iaYBR5639zvh/XXHtvf1Fs6jC4naBQO+kwAsRtVxjxZdWq0AweJj7T308Mp7k+LDIJ2Rc
	BQYQJ6tA7MMXx+txub7sfsMOgmk=
X-Received: by 2002:a05:622a:1453:b0:517:7e26:36a4 with SMTP id
 d75a77b69052e-51c4c2c14b9mr140647271cf.34.1783335935865; Mon, 06 Jul 2026
 04:05:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702021105.3406439-1-neilb@ownmail.net>
In-Reply-To: <20260702021105.3406439-1-neilb@ownmail.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jul 2026 13:05:23 +0200
X-Gm-Features: AVVi8CffNWtFbcBvs13jifF0StaOc8_tnG8CKCFcb9gVjjy93J7qwqRMN2Yb6cc
Message-ID: <CAJfpegtCL8S=zjv-pwxrX-9YXL0HLGb8Dsw_XWFF_H4Ui3MTZA@mail.gmail.com>
Subject: Re:
To: NeilBrown <neil@brown.name>
Cc: Steve French <sfrench@samba.org>, Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Jul 2026 at 04:11, NeilBrown <neilb@ownmail.net> wrote:

> 10 years ago cifs *did* use ->d_time but was changed to use ->d_fsdata
> by Miklos with no justification (a00be0e31f8d).  Miklos: do you have any
> memory of why that was done?

Wanted to get rid of d_time, as it is no longer used by VFS, only a
handful of filesystems.   Still a worthwhile goal, IMO.

Thanks,
Miklos
