Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BECA36EA80
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778197083; cv=none; b=FowIxg1r3/vpL4/vxj4zSKIZsysfCYfLOA6MHxUutVgHcMKmXxRZtOuhwcnx7a7nyQpKe1KouSL0EOhmU+UvWwMhDhknDqfFI3veBViHYcBi085qzMlkKbv2Li88OOs3QjhNNSWGOyjJTt5+qpNyzj4qp+2etoxV53xsPZkKBcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778197083; c=relaxed/simple;
	bh=rlUKXjVFvAgw/pObKoHWVbgIVv95xIqzR9/d2z/bWRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQwzQl2GViuUjVSUrXO7QMlnnsasucH2dh1BBkbgklE4BL/XDA578IQ9zR/7VM+lfFzDBwZJvXhy9vhwWOiVDp/IObV6JSwoFK4EQ1OeOidtkzX3DBHbsKnqHTX2psax1mvHDepCed2jxvJ0E7VAam7qTa3B+OGpP5ao/Otll60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQBKSseb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQBKSseb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ED12C2BCF5
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 23:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778197083;
	bh=rlUKXjVFvAgw/pObKoHWVbgIVv95xIqzR9/d2z/bWRg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nQBKSsebZ5YkKVfWaGkLUF6aNFWaDEmVClx9DaDCUCtIw9zUQhF0lsLMzK0yPiF7J
	 PTnP9Oa/5TIgFW9WORQktxtcwZd2e7E06+cQogU6o72VQgUr1Ml38roq4uPJt8n6y9
	 Y2+8Xmgp3OF2jvfXTfRr/Khn+dviurg5fYbBxB+txkwTGvMqmkBbbzv107BzTIYVew
	 ibZKpFau3semVcg5aDiWcveGJWRv37vLEu5vuk0MAxnt5R7HK6Yeqer7xov1KPDBxJ
	 KjOFa5naBq2IE2S/WCEkxlof+H1rBImLlCM4nYwXeTvknwx6kGUw0ZQSyCaF+JRjgW
	 xHX9pEgjOWWHg==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67e2498f3a7so2003816a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 16:38:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/QWdqc6rS/EhcUrRGCVjwSLuNx44PKToYNbkSMJi6O5mewplhknEjkVRyLfAaPjXvNOD33VAbXU+14xru8@vger.kernel.org
X-Gm-Message-State: AOJu0YwetkfMY2c5lRoDBXkkrJu5OT65ufW/kiKOIKupIaFoyWaRvNPi
	D/lbpzPvU1bfS3PoXnq1BDRU0wTeeV8BWV6m7mWYnKbSs26YBuG4Yd+uMv/eII2JnaHseoeJiJT
	48oPKijL5bTwDP0rfuh+yTQW0MUxBb78=
X-Received: by 2002:a05:6402:4413:b0:67e:2498:dc77 with SMTP id
 4fb4d7f45d1cf-67e2498dd9amr2651365a12.6.1778197082060; Thu, 07 May 2026
 16:38:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-4-linkinjeon@kernel.org>
 <CAMrLSE41=jUxnzAHve5WSVg4Vbx-Xp2QU+UdX9PFLdkY3Y9OHA@mail.gmail.com>
In-Reply-To: <CAMrLSE41=jUxnzAHve5WSVg4Vbx-Xp2QU+UdX9PFLdkY3Y9OHA@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 8 May 2026 08:37:49 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_mYTc1h6pAR+EKKyrAkOsKSNw8BuTTxfJG5Ec5ePmU9w@mail.gmail.com>
X-Gm-Features: AVHnY4K-pkSIg32yHTRb9NDade7FFiCve1gJVlMBcCBa7MAsT-aI3mDmADqsYgA
Message-ID: <CAKYAXd_mYTc1h6pAR+EKKyrAkOsKSNw8BuTTxfJG5Ec5ePmU9w@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] exfat: add exfat_file_open()
To: CharSyam <charsyam@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 10:52=E2=80=AFPM CharSyam <charsyam@gmail.com> wrote=
:
>
> Hi, namjae.
>
> How about this? I think err is not needed.
>
>   static int exfat_file_open(struct inode *inode, struct file *filp)
>   {
>       if (unlikely(exfat_forced_shutdown(inode->i_sb)))
>           return -EIO;
>
>       return generic_file_open(inode, filp);
>   }
Okay, I will fix it in the next version.
