Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0379D3B7742
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544247; cv=pass; b=nH0132gxR0zdFSnqc6+oHwWZbZTjbJHqAxzylTxY5zQWk5SHHIlimjCs2rgnOC/Huzg/6XH3yc+y2uSZRryw5OAYHnfEN+Pyg+WTdsgzJtTsstOxzl2zspijYOk0j3s5NAInWlFzdtS8JyvTywzehgChjFFFeOOmyP8ItLsYpVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544247; c=relaxed/simple;
	bh=fQxqZpmVN2OjS/KTdRomuIujK83Xx3uJi3ZT6vlrZ5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOvhXPkx2yr9rsOcqBlGlblqZFaS/pxeYdrEA8w3dz6FKETBXbzJVhG9GVawXk/8Ym6++mCU47CDbw8LerME17lgkWvlbi3460UXqBkfJ7uNLh04XrBTCJMhGka53q1RwVqUMm9v1MxilCHnXhceD+P2mlj2EiASWHr+sQ5uCPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRGL3DYF; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRGL3DYF"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so6455015e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 13:57:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783544244; cv=none;
        d=google.com; s=arc-20260327;
        b=l6pFRTuGi/8IYY122rvqL2QYtjN2TYdINyxgLE+eiNch1HZ3NYLpIjwhltHq12C2oM
         WJKdcXOaX43CcFhvcKaJlDHABSjNolSETuSaFXgZbrTOvSfv+pgQM4ONMVQTEF9TdXPG
         e3KO+ksjgUoswmNavLQyzufRYWj1NAXQMVZxp4XqqLzhRIVdwAu/Re6Y6n1t+f6wHEFI
         47gMzBxchxly1D8rPqAek2lcNw2G+Y8+r17hOEByxkGd4/R0DL9fkAnLZo5ReqtHT/12
         Dko9SwMH4TfYkogwVUvBpGx5V1JOCyVkF+2/L4sP5GeS4v0OSyGP5P0WD8DvkfNRX7PF
         L82Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fQxqZpmVN2OjS/KTdRomuIujK83Xx3uJi3ZT6vlrZ5Q=;
        fh=eCeO4M8zAu/UcelLyMyohtWAeIIW0CxDnKeNlbHeLvg=;
        b=rzBQk+n3ofF1nO5YD5o8KgNPva/WrOeapWr0HtacoWMmC/+Sx6EVQ+6xCm4CF4pJa+
         4p1iZzY20n87vYKyd2fGhPuyslaxux/SGvaDYG5f+u14CYzgZq9anbNL6z+QoaYYlt8q
         BYHbvHR/5P0ryTTgICS1Ry7bsWPny6dPRhwJ2I90dq3XsNa5YKEu3CWqbm1yww7UTBiL
         cEChwMF8orDtrrMIfi768MyW79oooGY6ksPPk3NTBKDLQ//seGUDLHAXRnhL6XyL3YDy
         PbLAFENonOvauyOivFQWZ/ayE5/R+WTEVn2EGqydVDWtq52Tnr9BaA7iRv1UtdllMF6+
         Ifhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783544244; x=1784149044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fQxqZpmVN2OjS/KTdRomuIujK83Xx3uJi3ZT6vlrZ5Q=;
        b=VRGL3DYF3/HWVEPQi7js832v1iGwNNDxbVIjK2dD/vjclbwE7Q+2/dIWXK/OovusOG
         zS5AKlAaNWBdp785L5E0BUmEy2qVjTMdECIWVBy9b4MuZijB8M4srfZlOx59GhblSRse
         4mHQ/wfv9+5p34DqzI/Vygjgonp5w3jF3xtaGDtGEoT2oz6bAM/BO8NQ1Ywx90EdbnR3
         1vvIbj9Kj/7tVK0XcKg8X3s2403H1aGOHVBtIMrmA/gzhnd6GEmW/nVUOjnMsxb/qn29
         5UWPHdpFL37BJWWrnrGpwQWuGKUCC7VSyRnM0wrTiGDsgjw7wEJQSudH1V+cqA/2v9fW
         13vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783544244; x=1784149044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fQxqZpmVN2OjS/KTdRomuIujK83Xx3uJi3ZT6vlrZ5Q=;
        b=Hb2lq3tAon7PIKA7MtAZkqB2SYuT92QY7Ieij9rTin+8Kl6zDXsXp1CdAssMrc5Qey
         kqLSqU0izmRCv2Y1kjVt1/GCTomllrbi32fXAfp+TzW/9umy+Oelg2VmUU9C5FHYIq+P
         A+7gJPL87R+7rX+pN6GaY4P/N3jgTum4RUf4FTitJnDFgPoTCBLcDPgAfUJcorjpneuX
         eetK8FWUGw0swQlYGKN+AICUxVdwXAjzKcyPj5iQDsbGtm870GkT/cxBniXOHL1+3aZy
         +6bPIgrnORn6ugL547+osy5BPaznZBSPBqpsIzs6243cpK0fNTF7Xk8v4XKVoBXCIc1T
         VXcQ==
X-Gm-Message-State: AOJu0Yw3EytTeCMj8AoEAIuy9S2zSSyN1lz+aPn050CcnbTAaoDcewoy
	KdA+Nm5mSaBbSc4JriYCRDrGLqs+frKXxGuhwPrwhMhqINJkkV6boy1U+9leBWYH40qrlUghCgQ
	Cz2DpfesS1xt8MQF7uBgAn0E23y969xU=
X-Gm-Gg: AfdE7cmvS68Zu2vFcds8bnjQHNvCbBh3BQW49dJLJOvBrz/6Ne6XZkc7iuClwGWyhMA
	bhMaM5qxbg6wfoUm/lQ3xS/yOYrIfD68wv6csnOB3wON0JuXKYIQXWqqxiSFS7AOIgTBuXfJbta
	5owzm1u4CMDEKoS6JVCuZTNOh37z6F2bK4DjY9Wy2aN5DlzaI8fW6lZeBUASqtD+JrdTSorL8H6
	8moEa2xlwwOuOtjJNz4uccQ8KVRu/fETdo9cqBzdjMxZgNrAJ+HqT49xL0AeoPOYG0AMja179/r
	Q8QJPgz2kUjqE7pKzkCGkRwO7g1MV21wlt759lTKSCpQbL9MbFvQ
X-Received: by 2002:a05:6000:2004:b0:47a:c103:8a2e with SMTP id
 ffacd0b85a97d-47df0808ff0mr4522829f8f.45.1783544244470; Wed, 08 Jul 2026
 13:57:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520030357.679687-1-yi.zhang@huaweicloud.com> <20260520030357.679687-2-yi.zhang@huaweicloud.com>
In-Reply-To: <20260520030357.679687-2-yi.zhang@huaweicloud.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Jul 2026 13:57:12 -0700
X-Gm-Features: AUfX_myQ8YTw0YdCEbZNt9d5CTUFLRbMZHIi911QIv69S8S5We_R1LPqmYg6pLQ
Message-ID: <CAJnrk1ZnO50z7C_e0y-0SVUXtd5S39VMsWfzuwD4LEHmuZw_wg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] iomap: correct the range of a partial dirty clear
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@infradead.org, yi.zhang@huawei.com, yizhang089@gmail.com, 
	yangerkun@huawei.com, yukuai@fnnas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:09=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> From: Zhang Yi <yi.zhang@huawei.com>
>
> The block range calculation in ifs_clear_range_dirty() is incorrect when
> partially clearing a range in a folio. We cannot clear the dirty bit of
> the first block or the last block if the start or end offset is not
> blocksize-aligned. This has not yet caused any issues since we always
> clear a whole folio in iomap_writeback_folio().

If this isn't currently reachable, does this still need the stable@
tag? My understanding from the stable document [1] is that "it must
either fix a real bug that bothers people or just add a device ID"?
[1]

>
> Fix this by rounding up the first block to blocksize alignment, and
> calculate the last block by rounding down (using truncation). Correct
> the nr_blks calculation accordingly.
>
> Fixes: 4ce02c679722 ("iomap: Add per-block dirty state tracking to improv=
e performance")
> Cc: <stable@vger.kernel.org> # v6.6
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

[1] https://www.kernel.org/doc/Documentation/process/stable-kernel-rules.rs=
t
