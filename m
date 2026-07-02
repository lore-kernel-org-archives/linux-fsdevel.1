Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F7D3988EB
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996887; cv=none; b=ZNdEWOw39pba4z6cV+bzGaIfUtONs2fHoCydaylZXT+YAUx9rtOOBbHLjS6D0KRGE5ce6Ibn4mU31rP1pQZ6w0/yo2FOPu4ceq04lNs5R9SpxihmRlmtYh+AFIWuf+stgfpB9/ZnSf+Y7prBAl13aaQye+8AeaPu0NqGxl6te30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996887; c=relaxed/simple;
	bh=Fnj6BtGs9UI4YOjXt6IgpbJYZohd0rC+G+yfHAsjE/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSsHy+iWcqDXm+JCx42YzjxnlAqjug8TQdz5MBI90skgHprWNyTOwk077iX7TuVGshvqUIK1bhd7him54OocrQseRUcjeduU+XY+QswyASf8DG7lUtpJO44O3dVtYywGkhBaoOmy0cz+W57TVdFqw7B00JSr/uO4w7COCX73Q9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoQOVA1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoQOVA1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0F151F000E9
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996886;
	bh=Fnj6BtGs9UI4YOjXt6IgpbJYZohd0rC+G+yfHAsjE/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LoQOVA1Y4HGDrtB7XDh3dsK4BdSCsPaWDl58wEe2va7gbZSdk7e6SFQsCLk9MVPo6
	 9fBiG7ZrNwbJbjTskpA2C2nKCSpt54HDD2FH4K3/CwzCO1QJXr90Hnd8aFElToNqNw
	 QgG+OrxTS/3mtMZaBc7gCTA89095dd12wzHCaq0W9HoJ8a6J5/HFuPL4fEnsItdpg0
	 Uogqu+1m1khLpMtELviGOnvy/+7VUxBw3kHP0f111Q8X6Z6DpzRZlwTFCsg1KiSA4/
	 H5rVZL4oFmSge+5QXuJPE6BsO0TrWAsi9dW1CszwUs7TH7irApNJp8f5MTexI1z9cT
	 6dwgcEVmH+ILA==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698ae09e356so1051176a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 05:54:46 -0700 (PDT)
X-Gm-Message-State: AOJu0YxHvR+RDO74PxkaqXRhopLq74ULxrTaFOUSZYzOvjO2ZRIHJ3Hh
	k2x6WAsilnlvzzWgP6IYwa8OSpv2vkkKFSHuGNPYHYJSE3ZGC9JkzqYCDu/uDQJwsla7BlyVlwj
	f80OXNMGVF9PvbGUZMqiYO0ugYYpzQSw=
X-Received: by 2002:a17:906:5190:10b0:c08:417e:3696 with SMTP id
 a640c23a62f3a-c12a9d98314mr229071466b.20.1782996885538; Thu, 02 Jul 2026
 05:54:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702024534.847681-1-chizhiling@163.com>
In-Reply-To: <20260702024534.847681-1-chizhiling@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 2 Jul 2026 21:54:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-3RuD03RJJvdKGvLbm1QuwuGFhGDcAdmjQ+OStUxPCDg@mail.gmail.com>
X-Gm-Features: AVVi8CcGwNQEvaLtq_52d0z0RypZ3-sGdL8QtPBj0TfRXKyCLXy5W1DHnwrMs9I
Message-ID: <CAKYAXd-3RuD03RJJvdKGvLbm1QuwuGFhGDcAdmjQ+OStUxPCDg@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: validate cached iomaps during buffered writes
 and writeback
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 11:45=E2=80=AFAM Chi Zhiling <chizhiling@163.com> wr=
ote:
>
> From: Chi Zhiling <chizhiling@kylinos.cn>
>
> Writeback does not hold i_rwsem and can race with truncate or other
> operations that change the file's block mapping. This may leave cached
> iomaps stale, causing writeback to write data to blocks that no longer
> belong to the file.
Do you have an actual reproducer or an observed corruption for this ?
Thanks.
