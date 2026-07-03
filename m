Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74FF38398D
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783062406; cv=none; b=ksFMtzljLDk/3Qystfc976g2T443gJp7bsJwW6Ubh8kWJmLi2TuH+U+A+8vPLNTTUmQB20kGL2wMHbqe0Dht7p0Va2+mmZgDyVeGhJEz3KI9pg5vdIrvahx50onu4fcPtdG309CTFhRIvKNj3y5CXmYX31hEKPZ0AMKpPLjxRe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783062406; c=relaxed/simple;
	bh=MAX584q8Bf9oJv0xG1C3L5CqaK6oWhvBEcxx10I+oEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZhJBtBXXzfxecyyROggOWcYesgZSauW9yvF1HB8VqPr7uKzlrx3s+EqmSs9HBYjyqjdrb9oGXtz4ACh7ed9f0kRUBRptdjdIgDNFsoPCbZGCGy9ZfdoKMnlikF2VAU+sQttduP3YfFk1ayCfWW9uB9kFRTQhn4Yr1xdMrnp4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKOCUNTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKOCUNTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0D81F00A3F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 07:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783062404;
	bh=MAX584q8Bf9oJv0xG1C3L5CqaK6oWhvBEcxx10I+oEA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=GKOCUNTZgKk4Sw22hh3T5pk/MEUarjHvXYGdD+TFH3ce46NeJStJ52QAIhml6l3ZQ
	 pqIpxwKoJYVXB7canjFKReL0t3DbtIT+MmqP+TMB9i8sPQ8f2NZu2HMYT6L81uyPsM
	 SSBdTvGGEFuGeFPnu/J/YZ5vtAk7DrmDGbtFiFr3waKuNQFFrewlAbE6TFOs9+Ksk4
	 E0iLzTQLE17mWU+pQSwxmQBpSybkURHqNDkuPqCFuNW2GT686dyXw+jY38ejaKiENv
	 IRodl1Knuv5I7wAVkusnH7T4iYTEuYkFBApjoxgzYnA2LCdu0FjfPw4X+Hl9686okG
	 /FPKw53V3Owug==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c126e47a82cso20410466b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 00:06:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrDFUvSENvm3JtdPxghOvQxl6wVgoQSAa1k+PB+rhG/iUiN5fztWMM7WhMank0RRT5ijwAPHJNczfHUFGKy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqrww1QjGrTynn2goQqXZsMGE/5wwyP6Fw5lTQp1Z7naxoffDX
	Mz51HsBgNCckjrtFytqx+ZrLvlwxDbruvSSFsL1Y4tsFsVP9tYPar6pGevs035rWJtIaENMO8gq
	QARqOBo9ZLJ+nmzTyFst5L5zcoAUFg6A=
X-Received: by 2002:a17:906:3b0b:b0:c0b:f304:d5e9 with SMTP id
 a640c23a62f3a-c12aa1766c8mr318163266b.48.1783062403275; Fri, 03 Jul 2026
 00:06:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702033656.23048-1-zenghongling@kylinos.cn>
In-Reply-To: <20260702033656.23048-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 3 Jul 2026 16:06:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-2nR9-=O5DYiw6x9R4KpuiV9eqH+HwiYxdAmihw4PvYw@mail.gmail.com>
X-Gm-Features: AVVi8CftQxzb-TjQTWfS9aaHyP6rVkjSuHj_85ulbR1x80mW98lAFqKge9IPlfU
Message-ID: <CAKYAXd-2nR9-=O5DYiw6x9R4KpuiV9eqH+HwiYxdAmihw4PvYw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: validate error codes in check_windows_hibernation_status()
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, charsyam@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 12:37=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> check_windows_hibernation_status() calls ntfs_lookup_inode_by_name()
> which returns MFT references read directly from disk (untrusted data).
> The current code extracts error codes via MREF_ERR() without proper
> validation, allowing maliciously crafted NTFS images to trigger
> incorrect error handling.
>
> The MFT reference encoding uses bit 47 as an error indicator, but the
> lower 32 bits can contain arbitrary values. If a malicious image sets
> the error bit with a positive integer (e.g., 1), MREF_ERR() returns
> that positive value. This can cause the function to incorrectly
> interpret the error as "Windows is hibernated" status, potentially
> leading to the filesystem being mounted read-only (denial of service).
>
> Fix by strictly validating error codes: only accept negative values
> in the valid errno range [-MAX_ERRNO, -1]. Convert all other values
> (positive, zero, or out-of-range) to -EIO to indicate disk corruption.
>
> This prevents potential security issues and ensures proper error handling
> for corrupted or malicious NTFS filesystems.
>
> Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
I think this should be fixed in ntfs_lookup_inode_by_name(), rather
than in the caller.
And I will revert your previous patch ("ntfs: validate error codes
from untrusted disk data").

Thanks.
