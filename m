Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2C3A7591
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635698; cv=none; b=KdDjg9e/sAlRtnJyl8SrlHgdFgZ+JVEY7Itc3cn7R4Yj4XG+oHfKQ2zSo2BdNqj1GQr70esyZJaIISdrwr16aLB4n3nWu4ng69FnYL/lru3ANBRGpw+NtoDKJ6OTzTyLP1dd8If4xQdMphuf2ezPKR3wlWCZcATSnw/Zuh9+FQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635698; c=relaxed/simple;
	bh=c9y71GpbFpZGAWIhix4KUMxMoJU8+7VIqSYPW7lJs5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iA87X9cQPhWWP1eHk9m3ovoeYNoXL90NejtMaz3dr7BduP34y73Tyvc1k2Huzu1R9epBu+UZq4GGsKbiYg9adm5en62tedJy9wi9DNTTL0DROmErOJ8hpnmvgzoen8for6qQH/jgP/L/ALdzNzKliDJIjg5lndfs0E9tWwtClJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOh5xudL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOh5xudL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1EE1F00A3D
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 05:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787635697;
	bh=2ibnJYW1W3WJ7maE4BMT5Ff0iHfq44GNHVOrNrkZzOo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AOh5xudLSGj21+FvCDzIh8YV7zO4GBOmjLO1ls4Y6irzTMl/VXuG4Kpv4M0XmUY3o
	 3aPk4rb/n9UHDdHKCaxbbPHMkUKRUOz9H4UD6OXhc2rinYksXGS5LcjtwaK1B8QeFk
	 0Kjw+e6hvjvrokLUPhqNeLCJUR/YSGcAOzk+4YWnszbOTYSnYBg7JaWcR+NIwNs0OV
	 Df/829Gc0rI3CKz5F/nbFayS6k/sVT/knL0iqs/qQL88o7B4rj0j7CggXnQyX8jM/D
	 c8+b9pVERFm5F7JJxb/yV4Q0eCq9P0xB3d1tUhmxYe/5wihcwvfofWtpU5qlae7mvK
	 OJdYVhwvXAIkg==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c15d47266baso497269066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 22:28:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrfxs9xB1IhSMe4QUEWrpSRG3x1x9kL5c0lg/zgKOS9mTT/ykGfbKvWgGSJFD/jLv5sUgSEkAuFsADqx318@vger.kernel.org
X-Gm-Message-State: AFuF++nCGfDZVmS3HMfZMLHu8ER2/+8L86RFUAvZrUUnXX+KGZTmiv12
	6NGbUtlUhIwAqYcWbntVPA3KVXuyxM6EK77KHAhGMcmlQJF80827pLs/33HC1WpR06DRMVIoc6U
	gKVpZQFKTJ17w9UAOeBuf47Cv75Efx/8=
X-Received: by 2002:a17:907:6d26:b0:c1f:9cdb:9965 with SMTP id
 a640c23a62f3a-c24e584ddfemr365363066b.2.1787635696208; Mon, 24 Aug 2026
 22:28:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a88e220.1e1ac41d.2d530b.7cac@mx.google.com>
In-Reply-To: <6a88e220.1e1ac41d.2d530b.7cac@mx.google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 25 Aug 2026 14:28:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd90WmfFBtf6DPtF75vcGjfKcwUa4yWdgXDZt0zCmVh-6A@mail.gmail.com>
X-Gm-Features: AcwNN1XBPj-oX1a_5MxYayJw2NVLPOvbjYV-dsCZ7bIfgW1IwUtRHMdAx3cXa9M
Message-ID: <CAKYAXd90WmfFBtf6DPtF75vcGjfKcwUa4yWdgXDZt0zCmVh-6A@mail.gmail.com>
Subject: Re: [PATCH] ntfs: bound $AttrDef table walk to the loaded table size
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -1737,7 +1737,7 @@ static struct attr_def *ntfs_attr_find_in_attrdef(const struct ntfs_volume *vol,
>         struct attr_def *ad;
>
>         WARN_ON(!type);
> -       for (ad = vol->attrdef; (u8 *)ad - (u8 *)vol->attrdef <
> +       for (ad = vol->attrdef; (u8 *)(ad + 1) - (u8 *)vol->attrdef <=
I would prefer not to have ad + 1 check form a pointer beyond the end
of the buffer after the last entry.
How about this instead ?

 (u8 *)ad - (u8 *)vol->attrdef <=
          vol->attrdef_size - (s32)sizeof(*ad)

Thanks.
>                         vol->attrdef_size && ad->type; ++ad) {
>                 /* We have not found it yet, carry on searching. */
>                 if (likely(le32_to_cpu(ad->type) < le32_to_cpu(type)))
