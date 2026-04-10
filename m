Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8024B28
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775820846; cv=none; b=HhTF2S4vX8RtSsr8cYJAdY5yroAoQ62rvDag6tLG2H+x3lr5esgtJiQVcVlpnkaTPuFE5y+9JLQhzB8qW4wGI/fQVDlB+R9ZcAOhL3y6a2LETi8k/dmEnZq/VdQmGc+Edl5fEYXLKVQlqUzp19462EhufdF4he3/FpIOsImizNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775820846; c=relaxed/simple;
	bh=8QO5SRVNz57c8mg9zXkclZPE8ToQoIseuP5cqwgo538=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C19BlWBtI5JUh/SrLc03rL8soXfbGtt57pdJWV9jAoeJgL12MzQYBM0ajMgOo0dLSyh6qqvMhyHb2g2cRKuUeaRqzoKomj7uT8HLvYIHCnq/T6qvH8XnaYS/BxgojDRsmx0HgzaDQ4HDAVCbODebAiwLNoQGED23BTmq+reH878=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b4otvoX4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b4otvoX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75E1C2BC9E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 11:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775820845;
	bh=8QO5SRVNz57c8mg9zXkclZPE8ToQoIseuP5cqwgo538=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b4otvoX41je9me7iNXENnTkjWMVqY77lZ+QT/ivHRIvgyKHaFT5xUqsNDRxZ9yMQb
	 Yk00WnqkYiPPI57OrDWoHGu1T/bCUlYNkl2IXwCR/JJpeOTzD1CK91Bttoj1rVe5VR
	 9xBqLd6DzuHae5lcO3TSqx6LGpsDoro7MuGaeQ/+3r7dXu5yquEAunKqX7Ogcu6a2+
	 rJcROSyYiiInZM5ZOqE5u+9z8Dl6AeUiTWM8T7nAgvA2aMsb0d679arExiqBHvChWi
	 i+U966eDidHst1NztEDmcDXCyus5Z+Gk+71YnapcMA9U3JKJtt4oJbji/BY6rIxlMD
	 YZRd0HOa7jqTA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67011a751d2so497722a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 04:34:05 -0700 (PDT)
X-Gm-Message-State: AOJu0YxD33xMocS83GbQyV/NCY/xdn9UP/h3TCZbig3Z+7kFtVieVsq8
	KdZZ87O13mkoLclSCtxIR665Pq9SkQsmz8Wisx6UaLX4IwBJSXd5ez2K2hXLBJNCYJY6cXea2G5
	ymuZ2/Hc/lRzogZoPjVtAGdDxj6LDAcM=
X-Received: by 2002:aa7:d519:0:b0:670:8acb:fadb with SMTP id
 4fb4d7f45d1cf-6708acbfbdamr931607a12.0.1775820844234; Fri, 10 Apr 2026
 04:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adiTg9E-Y4PEKwyG@stanley.mountain>
In-Reply-To: <adiTg9E-Y4PEKwyG@stanley.mountain>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 10 Apr 2026 20:33:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9bMOwmYQc4buD22nSRJjBJRMPztiyFAPhARupZ5U+MbQ@mail.gmail.com>
X-Gm-Features: AQROBzASpheqAnqNYESEc2JCgwzvtO5VGeUMo-DG1M205M324RZar5uI4Pssh7I
Message-ID: <CAKYAXd9bMOwmYQc4buD22nSRJjBJRMPztiyFAPhARupZ5U+MbQ@mail.gmail.com>
Subject: Re: [bug report] ntfs: update iomap and address space operations
To: Dan Carpenter <error27@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2026 at 3:07=E2=80=AFPM Dan Carpenter <error27@gmail.com> w=
rote:
>
> Hello Namjae Jeon,
Hi Dan,

I will check your reports.
Thank you for the reports!
