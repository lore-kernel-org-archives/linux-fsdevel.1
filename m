Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EDB2DAFBD
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 20:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543251; cv=pass; b=TaF6wS0HtosbrPqV6KwEaqXnPLMIIlHuzKAG2l9ZrrSrM7unmJ44zQdA5eco7PY4xOCbGZyOvhBWy6l8NFwpvm3qw2nDcLIV285yaFNjYBkJiYap4FY6g6y+i9hK+MZKTShu+M3JyfaIku/0EmwEcXtxguP8G41wCIGbzTfWnaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543251; c=relaxed/simple;
	bh=eg8AbooWrchGP+5vFOVL+ntc126BYRP3715RVKn8f0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PV3bkmEnS21/ClwIil5UBe9FojySelTSWsMad2ngLTuZYPajQWNUfbY1OhbXlUKUXrryEU+HrXQD6RugOEt1VEEf+jwqHXlvfA5R6xYwmVW975IrP0y3zJnoAZzWW0pksXOFDFSXCPOOU9/r/Lcbc/0hbaa2jWoabGmqtacetVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQ+cZroD; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQ+cZroD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4938d5f86f3so1887905e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 13:40:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783543248; cv=none;
        d=google.com; s=arc-20260327;
        b=nh8w9dz8gAqK9YEi+G7byCIqfreiXZH7pJ8wW3H4it89r1Z8nHMQUmGjOu21xfzi8n
         StAqCQUSZ3P2h0BytKoYoZZGa6SKVHgba5Ut1uXZers0J9MpVrxonYQ8GZdooeI/tfTz
         088+0ogVqCyIhzxAykc/yaWuGZb9NKSlxZSrt2q7mqqM3O/a8Kgmy9GTRIyOClhHp2jn
         MDyc6PhpI9pepq7g6iPEq5fOGGiBR2zQqwhZzFmTl1WTGDRWYLrK6WQ3tJrHiURf0Z5o
         mAefbAQgt6KVX/oQWpr/4n2iAb+jRiSQF+htpasplh6TCr+uja8wVZJrJUmH4Rz7X2PD
         ABiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HV9dnVAAaywBkhcRiF+JFXkn347nONXaAEt0CLNpRQI=;
        fh=eCeO4M8zAu/UcelLyMyohtWAeIIW0CxDnKeNlbHeLvg=;
        b=nXQV9YstB0oeXNPX9rRXzHrf1R+/6A4VbuAPE+fFMYI8/EvLECTNp0pG+Lxht9G550
         +WzamxrzRUi9nlFkQmbdN11t/RUvIZcCMY8j7lXR56K4lbw3a9ghOxz0b4Cy33j1w7nQ
         QG4aU6W28gQykGob6SB8xfl6OxVKBg8T+PG4rXRYikDAuxzjXSHhPnxKR1uNjl1AcRup
         AwVHdjWBtcP4BHSUIbHtm4L3E4ayVmx1EiG02/SDMynERtE11tQC67oD93FN2KVva0fv
         TSpeXWqcq+nXYVlHebAaU9FZs963PmvASPvSyXpCcmgc94RiuI1ROolk57cjKlXXV7Bl
         QSHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783543248; x=1784148048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HV9dnVAAaywBkhcRiF+JFXkn347nONXaAEt0CLNpRQI=;
        b=lQ+cZroD0jZkScclfjtWa00kCjT+PAxETGJyEK7+MoJOgGcJfOBwrgUTGSH11L1ZOe
         JQmuiQ3lAyVZSLg8RH8T5Ry6no97tde53KzCbFfeiQU38p76utIP5b5/jerLTgEmMtio
         OPwiSKZeQwIOz9toPfuJ8CNEp+AyhddX0/DivgP++tTSKhrSYxKKsOajD02y//9R63I0
         twlBY3cXsJ1W8dHhCHwWqXvAt+Tx2hse5BzZBkPiPPW0MATnPGnCwTOD8jhhSHNSJxrC
         dERfkOhqyDcn3kCkxlXO7sKzhe4vZEP9p/DFZwjtTtnpxzvUPiMmdpx17RC/AOWxlcOd
         TDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783543248; x=1784148048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HV9dnVAAaywBkhcRiF+JFXkn347nONXaAEt0CLNpRQI=;
        b=fCPkZgOb4INUDOp1KyybBgLHn0alitkhf0Wl40vUY0rNzCyc+ErDCswTSqgrmhvq4g
         uWo8WRSlOTj7U+tarvGcx54VRkdX26m1X1EWLsa2miTBsJgGOg8BxM4Z8txpOOVy6RN1
         VdOj4lp1ngviYmEEPwPbQRVCC8P1kMeJVz5g34u0NSwr7MxmezKxb8T2TSgOgP4ruoEW
         +9h8ohiIpwQj/ZwtRtWAsvdtehypwQ8BM13gaEW4u4ED5S4mpPpM/Jfq5bN61xvk8CUW
         IBsJU4DO+eB+TPW6iqeNIfnNODouLQ/I4ywL+aZw38bdynaVenRCZ/Dosgf7t5BRjh/0
         ns4A==
X-Gm-Message-State: AOJu0Yzx4S/YhW/PAnWJDmVrCxgNb1CvuKRNXwabTVEqdYmeHDSzr86i
	YBpAbi9QyvitDVKnEHPzkDA3JKRK3vxnKnNVlOUl84oX8dUT4hXYlFhQGDubIdJYS7h+Fs/oID9
	IyekzoXO5sOzXtfcC3cZXfKt69AGtHvM=
X-Gm-Gg: AfdE7cn2eNi+I39J6cQF8sn6kSCGDRKMsHbBMOt6crZBSqFpDfVLnxAiB/5nDV5DEQu
	M2QnMYAb50ejmiNZIHSOUta6hM8+igN1wiDJmcvMUt02eNK0TdeedMNm9egQM2UGDQPlr3tgFTS
	lySURhFVDbg4/lp8MAFC+7dsb2CW9bsKi0i2fVfpTPFBmUXY9vfWdDi37KTWiSnu9gBBj+Z9Jg5
	VG5FE1WPc6tdGroBI0FDyrzk5m/9jjaCcIeYilYPQUNjKgywN/Ofa6Y94gapQkQHPJtr/hDJHy9
	uCM9aw3ccuYXsyfx2HW3Bamb3ByF3lCys/EUli43Jrpc5QHNwN7ckIb3uYgS+lA=
X-Received: by 2002:a05:600c:34ce:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-493e1008fb8mr97418115e9.1.1783543248191; Wed, 08 Jul 2026
 13:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520030357.679687-1-yi.zhang@huaweicloud.com> <20260520030357.679687-5-yi.zhang@huaweicloud.com>
In-Reply-To: <20260520030357.679687-5-yi.zhang@huaweicloud.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 8 Jul 2026 13:40:36 -0700
X-Gm-Features: AUfX_mxh6mA1e0Oybe36TV4asjWw4ulMFew2ORY6N1hqoUi0VoqQJD26mBrzs8g
Message-ID: <CAJnrk1aBgAFu15wp3L-V34OU3i+AtMiDqjvhHtO=+ZMJ4yvfLQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] iomap: fix out-of-bounds bitmap_set() with
 zero-length range
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, brauner@kernel.org, djwong@kernel.org, 
	hch@infradead.org, yi.zhang@huawei.com, yizhang089@gmail.com, 
	yangerkun@huawei.com, yukuai@fnnas.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 8:14=E2=80=AFPM Zhang Yi <yi.zhang@huaweicloud.com>=
 wrote:
>
> From: Zhang Yi <yi.zhang@huawei.com>
>
> ifs_set_range_dirty() and ifs_set_range_uptodate() compute last_blk
> as (off + len - 1) >> i_blkbits.  When off is 0 and len is 0, the
> unsigned subtraction underflows to SIZE_MAX, producing a huge
> last_blk and nr_blks value that causes bitmap_set() to write far
> beyond the ifs->state allocation.
>
> Regarding ifs_set_range_uptodate(), it is temporarily safe because len
> cannot be passed in as 0. However, for ifs_set_range_dirty() this is
> reachable from __iomap_write_end(): when copy_folio_from_iter_atomic()
> returns 0 (e.g. user buffer fault) and the folio is already uptodate,
> the guard at the top of __iomap_write_end() does not trigger because
> !folio_test_uptodate() is false, and iomap_set_range_dirty() is called
> with copied =3D=3D 0.
>
> Add a !len guard to both functions before the computation, so that a
> zero-length range is a no-op.
>
> Fixes: 4ce02c679722 ("iomap: Add per-block dirty state tracking to improv=
e performance")
> Cc: <stable@vger.kernel.org> # v6.6
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
