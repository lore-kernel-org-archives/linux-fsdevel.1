Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA485370AC8
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781164734; cv=pass; b=dZD8zl+8SzGZwMh4MtQE0JFOQfpkrW/7T6gTefUjiR2gybZov77Iu9kO5zvMTcPnOkCTy6DCczXMukd1ZFYUsWeYS4daSEint+DeNF8hz5izMvIeiVxmfROizotMuYva2sHf9Z6eoe3iKQ/9dzz0R0rgs7tYXYYsLC5cM5xLCCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781164734; c=relaxed/simple;
	bh=Lvp4SsnY/TmP7AbpYlNx4Qa2MVwlmWL/TQUA2Y0M8eo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIosZ/BDVP2VQYQF5j+ROO9xDLTElpwcewvox4Ukjylodf9Z/kfeDLvGWxZgfRQv4d2AiJtszanswf3inYqoW/uASHuLD1sBlVCPmvPWA8MzkYv3WF9hn8rtarU3jhXiS5zGSvV339UlyI8Z2wVxWEq9VvrmQB4KQ33zMdIlYxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DT45GBxB; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DT45GBxB"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5175eab3a93so58914681cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 00:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781164732; cv=none;
        d=google.com; s=arc-20240605;
        b=WVqiqbKgtsbORjmQxu79OAAbdepVLH6jRti7jZpRFg0/Z48+SFqaxAMTgwlpzYAeFz
         Oqu3GcbyJXqzRWwgiBrJwLVxfTJbbX8CjgwIHlKvIJm+L6Qk/C9D1Tjl8reUCls8NiIh
         pL7Ma4eRQ6g1BJ97+F/K+3h+BGXJvTc1Td8COvjndbENcrbXVbvVG2VaiKhntTzTYR3v
         txlHYYTNU/DaQ3jymYD01aUJkkhNXSsFtJohybnhFw8aPM5qS7LDUNQeJ7j7zOgVBeYw
         kMZvADJtso+fEq5q5QrWT96Eaiv4J8QUTpTBe401kun34tjNW3tV1Pwcy5V04SLYc7ES
         5DnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Lvp4SsnY/TmP7AbpYlNx4Qa2MVwlmWL/TQUA2Y0M8eo=;
        fh=hQoZ1k+GIS+8pUMypyKf/kWdNTGtDjxnInDuDkps0K4=;
        b=GS/MfcAo0Fyr8RwqgUaV6MS/eyZzNPWR/RJK2FANqXNRBNlxSMyQb4bwAsVDJsYt2j
         VcgV6m7t167bBCUgqDcAvujp7P21m4Lt6tubQaW6i/yJzpi3mSBuwgLfjd15L9ZNRObh
         SU9o3iMyYcelo2KLK/QQBWIUDHghR+DuC7ILIkHSSw5E4x93gDwAMMSeWMQnvp9v/8zZ
         qAKED6uDg8piv9NWCekAZqTX/JzsNoo1FX53VLpCErW2NkGS3hNofkJwTh+zrDShbadU
         c5rBbjy2tVBOia3EScvQR+g3+ZTi1qS3Vjf4cKVfEKpwqAL06KWAIoPd9Nft6zRJBlyl
         LLdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1781164732; x=1781769532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvp4SsnY/TmP7AbpYlNx4Qa2MVwlmWL/TQUA2Y0M8eo=;
        b=DT45GBxBNQsWoeSMoEErgy52mUsFhh/DgjILdCc+DUJeb0v5YAJtuLbZYkU0rA7QeI
         RpeccjcmSn4UNahfwvIIjAGsUoxO1CY70scQqz1Tf+6AtmuICT6uuKHQ08NnaLFa9yQP
         lsRmEGnJrK2jwhlFQQaei3PffL+339QDS4yaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781164732; x=1781769532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lvp4SsnY/TmP7AbpYlNx4Qa2MVwlmWL/TQUA2Y0M8eo=;
        b=EvElgzuWXKYhqi4jJOlXpycSluY9OPsycICXHlwbUO2N307E+3GNliZWoqoFp2IwX7
         o8Tx4LI/uocjUcRsZnFimKc4/su7Pwzm45HoRMlrZzld0aP2LSHukU5Uob6+aZqHQ20L
         XVb2LUsPqa5DNTFxwxMj26o7J/YPG0/rBi7LOyZ3SczR6niiS0nOOu07ZppvVe90jBHJ
         YzucWlPksq0y2MSwFaY0ZPvJWxp6xxyoBp5I6h19/yyeeX62TLW+VvXaNQKNGC8hdNVf
         8YI5xgCy/ecQdlFXiuyaj1O5GgxONnBl6H4oSU8arCINoFM2rtTCT0A5YDytDJZC0J0n
         TicA==
X-Gm-Message-State: AOJu0YxUl6mo1SOgf7Kq49v6OCV7OLKXF7N41JT85NFo26kaoWiF1EoO
	Z9ywUBWZvuncKlb+wWuZd9568D2jOlSYxCYngjQbN4TaaFBt3VYR2BR4CEcI8eEHE5m1CrjNAbI
	mYdlX+J00GJj2KZ+o2njl1C792ik6u/uAO2O4yF7uUw==
X-Gm-Gg: Acq92OGBuikfSgARvJtNG9yrE3Xt5vVBwTh4BW6H+P3PY15mipboEqGLoypARR/8Zxu
	k7q35jRPBYleO6IBu++cBdlR5urv9UCALLkinQ+D3Do7JWuDbfi+mpLKxSr3Nnnpam6+rDxBmG9
	PKKr677A2gMBEb/7/E/XpeFbfKJnyWQlAiehPOE1U9IZBZf7vh3u7kVZUMK95yMfTRnFNc0EMfs
	MmiU/6fzSF/POoxbOoAavuPtIVEe56FqTgHLuU46q9cFoFULEivuk6zzwj8qWsZzfN7AHnUUKXa
	MpvCPLjzynAngqjgitDbzUobhBA8cGrZbohk/QDl0XUsRZ3hTuw=
X-Received: by 2002:a05:622a:2592:b0:517:7bcd:1908 with SMTP id
 d75a77b69052e-517edcc9d02mr28276681cf.8.1781164731760; Thu, 11 Jun 2026
 00:58:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225111156.47987-1-zhangtianci.1997@bytedance.com>
In-Reply-To: <20251225111156.47987-1-zhangtianci.1997@bytedance.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 11 Jun 2026 09:58:40 +0200
X-Gm-Features: AVVi8Cf3DPzF61UQJIIND7CRPzu9W69WI28a6P9WVgNgtKBh39-FjHYOEJRBlVg
Message-ID: <CAJfpegvwcRoYnYf5o4+w9vCAnp2a_CAhSC+EbiM4XM0CXSgJrA@mail.gmail.com>
Subject: Re: [PATCH] fuse: set ff->flock only on success
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xieyongji@bytedance.com, Li Yichao <liyichao.1@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Dec 2025 at 12:12, Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> If FUSE_SETLK fails (e.g., due to EWOULDBLOCK), we shall not set
> FUSE_RELEASE_FLOCK_UNLOCK in fuse_file_release().
>
> Reported-by: Li Yichao <liyichao.1@bytedance.com>
> Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>

Applied, thanks.

Miklos
