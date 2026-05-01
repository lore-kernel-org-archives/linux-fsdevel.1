Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F33603E8
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777634843; cv=none; b=Wz1ZuMGpTcER9Srf7VsmEE1gEfaZEwhEaV2Sx/5x2ZXadK3SWwyckFJWrLV498VIBBfGsw4r6oc6zJJQg68KNWUPbthytjuauUp1Ur+xVouL2GgNZeb+mFtuvjAiJ4gUQXD9uHZOK9BG8Zqc212/UdjXeLLb6VV0IyvaIGv+Xdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777634843; c=relaxed/simple;
	bh=WbJ/caDXp5+8byLcQMIQZyt8md+vEY1hs3bOtFiie+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJQXtHKVRfqbSmlCYtm93nwCwEmaS4IX9/y+raufqfccbj8sWBV7PzkELClgP3JtLuBPUO8kRzuE770KsfH90zp7sjKEEPDbsBfpa0d11ncD8vGYxH/JPMdR9bJ1gQCFl0N9qD5QXZIs8feSgAzig8lkh0B5LtuTxbhi+5OazVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u12W2KQr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u12W2KQr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4727AC4AF0B
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 11:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777634843;
	bh=WbJ/caDXp5+8byLcQMIQZyt8md+vEY1hs3bOtFiie+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u12W2KQrHkFsNqWyGlHvL0n+KG0VTPjqBh1a10v+ZmpfvUGc3hRW04slujdlMinsP
	 KdAi+kBu4x2IjSnTDitV60xXsPXzv0vM6zQW4FZsmdgFR0WUvSSO7AHq/RixonRB01
	 OU/E5DparXhuMgnaEbH4MVMrqm0ysC6oOMTnujYW9iM6Mdni6GiSvHxDDYKUpxx1Rg
	 M0y+E9wXE/xQFE64wBzuAElgXs7Keufh/eZKRWGKIieteN/+55/plsjd/k3B9rx5TO
	 8hiA9ZTu09iS5qXz0TXvGYfbLxY3dXuCRbXAm1WdI+QTf64qoKXee5kBgpJjXOd/dM
	 MajUQ//mIpKfA==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-676d8582a13so3353790a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 04:27:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9xjDIEVgElk8AmjYOmpihBwRiE2xjL/fOlSP4XBCOqGhdCpQMpmvHC6BA35rawYa1tNFXj8p7CG0cJt5oK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1nDC+NmMcGhdBdEB+L3B+B6vC3sSsJY5zYMgtwsMekC3msZLm
	hDJx8tqjJPO+fDA2ka8QFlnZT6/DQ2KKZCTIakswB0sPzSgarv8kt0sKaYyI2jubp8E7yz+bPfN
	zkYaoJl6crAyKK7xnL+t6+hp6poSyjHc=
X-Received: by 2002:a17:907:781:b0:ba7:f5fd:edd2 with SMTP id
 a640c23a62f3a-bbac7a9f27fmr461169166b.42.1777634841848; Fri, 01 May 2026
 04:27:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428235038.93816-1-dxdt@dev.snart.me> <20260428235038.93816-5-dxdt@dev.snart.me>
 <PUZPR04MB631687B9E5BF6066086C7F5E81352@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <383f2d82-5f31-49df-9c00-b76b6fa45370@dev.snart.me>
In-Reply-To: <383f2d82-5f31-49df-9c00-b76b6fa45370@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 1 May 2026 20:27:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8_9EpQw5w_0YNJ8FGZXmY7QsF6-6rRt5SjW==DSeYTUg@mail.gmail.com>
X-Gm-Features: AVHnY4I4IzVIg-zUiWeagsOB3sna3ignnXLwiCNp9zkbROlwprs8C08O4O0gDhQ
Message-ID: <CAKYAXd8_9EpQw5w_0YNJ8FGZXmY7QsF6-6rRt5SjW==DSeYTUg@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] exfat: more pedantic upcase table validity check
To: David Timber <dxdt@dev.snart.me>
Cc: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>, Sungjong Seo <sj1557.seo@samsung.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 6:24=E2=80=AFPM David Timber <dxdt@dev.snart.me> wr=
ote:
>
> On 4/30/26 16:58, Yuezhang.Mo@sony.com wrote:
> >>  static int exfat_load_upcase_table(struct super_block *sb,
> >> -             sector_t sector, unsigned long long num_sectors,
> >> -             unsigned int utbl_checksum)
> >> +             unsigned long long tbl_size, sector_t sector,
> >> +             unsigned long long num_sectors, unsigned int utbl_checks=
um)
> > After adding the parameter tbl_size, the parameter num_sectors is no
> > longer needed.
> Change the func signature? I'd like to hear Jeon's opinion on this.
I agree. It is cleaner to remove num_sectors from the arguments and
calculate it inside exfat_load_upcase_table() using tbl_size and
sb->s_blocksize_bits.
