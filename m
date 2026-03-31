Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007843624CE
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 04:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774932974; cv=none; b=ghrKKhgNo5/Gm+Ro0KQ0yyUUxzKP8h8UEsk/XfrazshmCeGYxGe7F2hxYW7JrhJZGpfakijzKftQLalQiFUAcjEKAC6Z9Hl+9Ewvki2TQoANgdEwulYdEuYNqDH3nDEjLhEWoDBi1zdKIPHVGi4bwNezs3+5J8b3lxGtj31yyog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774932974; c=relaxed/simple;
	bh=e5/qHvO5teQSC11VwSyH8tqeMhImQNZERFESJnHVpjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rARr2oi+zOp53rx5ZXjUZVD3xRF/zcyG54K67ZAsaqrJddvr9OA5UUZOG316vCTRPPB+909mIemfJYtRtxfRBjfmyLj12AMa9M+r8i0Zsq/Ti36J8HQXRmyEtygs0isVdPrrrrggigr9LITgG8nVQ1FYi5z4tAY6jLXD1QqUOEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eg5HMIMh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eg5HMIMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F950C2BCB4
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 04:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774932973;
	bh=e5/qHvO5teQSC11VwSyH8tqeMhImQNZERFESJnHVpjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eg5HMIMhSHp9x+UWRjWbXljfgLvJG/V7e18nFwsHkRuMiAj5iqQqIOgP/+z5s8+IG
	 UWkYw35WmA+M5F4PNHE26yDapviwBNUgJwEF/MxRw+CLqBzDfK7Q6xAOiDinC9IW7L
	 OB0yALT7zZIsui4rkL7fAALr3GsJbGWe40561Q2f+8saZik29Srp9RIiygMAuqcKEC
	 Q2M1g6/dTx3Ni4dbeuQ7EsgywmMWSZn3Bx+W2OP86q9WsvvV/zamRVKRqL4hB9gL5X
	 reKr9OGrw4tL+eG24Me7bSot0JWUAsnrufm46WzeAnB/YxbWg/mUYjDPSTQjLUSGvP
	 5yK4ln1S7Xq7w==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66b8110361fso5068411a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 21:56:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUenYvzf1HioIjFl2s/zvhtMRSwf9IE6jj+i+Gld0dLQPCu1yW3DvGEAEDKgvpLMoTUsDcqEcla/s3wteiR@vger.kernel.org
X-Gm-Message-State: AOJu0YzBITfS1KWPNtMMk+aYxUmRLdLEru5ZhHQXc2rwW6xZtq8AMS7W
	9hvLVt128ZrszwGnra/Y09xl2yMgkL8KcRs9GFo4LsPfPKr/bEBfHHiPGQ03xZtWLF2a2AAzZKz
	Zfm+OBozX+R3v58PhGUNeWZjixIsgHU4=
X-Received: by 2002:a05:6402:518a:b0:66b:b46f:cbda with SMTP id
 4fb4d7f45d1cf-66bb46fd099mr4914947a12.1.1774932972056; Mon, 30 Mar 2026
 21:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-6-linkinjeon@kernel.org>
 <20260330063910.GD5897@lst.de>
In-Reply-To: <20260330063910.GD5897@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 31 Mar 2026 13:55:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd__rwavh67QNTyJbTBz3HGNF6mX4r0XuBUqcVFfgVA2FA@mail.gmail.com>
X-Gm-Features: AQROBzADa11nuT6-XzUrwE3URoLCDZb22OhwmS-2qcV1jBL-1U1_6RcVeVcapBA
Message-ID: <CAKYAXd__rwavh67QNTyJbTBz3HGNF6mX4r0XuBUqcVFfgVA2FA@mail.gmail.com>
Subject: Re: [PATCH 5/5] exfat: add support for SEEK_HOLE and SEEK_DATA in llseek
To: Christoph Hellwig <hch@lst.de>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me, 
	chizhiling@kylinos.cn, chizhiling@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 3:39=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > +     default:
> > +             return generic_file_llseek_size(file, offset, whence,
> > +                                             inode->i_sb->s_maxbytes,
> > +                                             i_size_read(inode));
>
> Just use generic_file_llseek directly here.
Okay, I will update it like this.
Thanks for your review!
>
