Received: from mail-yx2-f1.google.com (mail-yx2-f1.google.com [74.125.224.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B45647729A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814411; cv=pass; b=lre14LJMBWltfcqw/0+0DEG5OhdJkmW4Ku0nBis/apcFrvg4ufLZ7rLwFU30cfkcvD0W3R07/WUjOEiV5Lpj56VLH2tfpYQQIA4q3zNQJ3bxV5xFIg+nl5LmyP6NQY2c+ER55jfFsLZ+0RodrG0fUpfuJr5F52FnIU7HGMBUTLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814411; c=relaxed/simple;
	bh=/wyxF/Lpcmq2UAtmRiyEA+9Tty5qfE+H9o7MYaoo/uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4/5d3FxnwKOfYjXHvL4rEH1/nuZTmQclv8sA6C7Y2cSj89jx+54OJVj0p8Js4KiHT0MKRN+6Ayp8lbcDDqCsSA2wZPfGa8SbJCuG3F47McMhkczEIyiTTEiN/Go9UAmfC/ajFbmineabgukSb6qHNGZRUgXkvG44PNydiCesso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqLCmKtW; arc=pass smtp.client-ip=74.125.224.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqLCmKtW"
Received: by mail-yx2-f1.google.com with SMTP id 956f58d0204a3-66d27631526so539111d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 07:13:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791814409; cv=none;
        d=google.com; s=arc-20260327;
        b=MwnAU5Rcp8dtteV65O/erM7f/MYCESfaPo7n6f/OHYpuedlOtJ6m7JJKxDG9nRX2zv
         vA1Oh9WdH7t4Gsea7dHlGOYyJhn3aP8jdLiv2qB/oJ6i3pdQKV5fFFZlWpW//l8oj7UD
         NerJiPtAGMMOdkZyV7gn5dUqTV6Z42xJBs8n5GtdGOCYHECVKYU16sHTQBa6ryAktnOU
         0FVYzaW7EfTwaLbjsCEPEF7QMSfnNherCsjlM8n70SZ2FD9UcwYRlg97XS1GkHkkpu8T
         zEYrjlKIz6Oq+vNafRFj9meN6omNvWnKQ3bZEXIApMwNKjfpybnnurOTC4RvRmyfmBFs
         XFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/wyxF/Lpcmq2UAtmRiyEA+9Tty5qfE+H9o7MYaoo/uk=;
        fh=wLw7ldbgbpjNAw3tW7Wk4G31A4blKt6ZTx/jrlp9h/U=;
        b=aoqXDsyDr7MDZ8k6Zq89KtfpRTkFxO89xxTnM4nxy4nU0taVFpUkr9gJz4Pt/eQYVo
         1SWX1eCjlEc7JGFonSeFMlLmNSR9MAza3m+LjSUPI9fMLn3pcdNOenSqewUmejfL13Dc
         7s9vT6GSspadEFEenEytk6Iri5PvEbJJjKXvB6UJGtYgBwxAfq82x8GI6ilFbSH8i3Qw
         +9EeYkQGSrZzJyI+DZZpWGcTNWVFT6eV7qM09k2FaZpKPuZFWuDQR6jX3wKtLUivivDM
         bp1szt+SL3sGUJ+M+jDj2zueKreMuE7f4EtNZTShWOxuE1x304m2Lblp8TX9AKrdrm5j
         E48g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814409; x=1792419209; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/wyxF/Lpcmq2UAtmRiyEA+9Tty5qfE+H9o7MYaoo/uk=;
        b=jqLCmKtW14QPluHZ2wMQoJ3goz+5H12vTDAaeiJUcNhqGntHZ1X1IGT5/FSa8lYijT
         GDUAvEyQ/J0lcArQdMs+nfO5haeEtcJztcEg4EfkAaN4w5fr5tfsOACT1NRBM3HJ2+IA
         J2kZAMggtBDx5eT2yleb6kcxr7mEd6pZwrse8rKm3ejH6sewj9Q9Owv49A5HY9+LlQHj
         d5fL9Xxzq1KQVd8NfXiDXoPtd0sBLbIZrHRSeBP6+Kgx4GI5RyJqe4dCrV3oWdjswrAT
         9w2LIE6f4KI3zd8VsOfb56IUQ+L2rz+IwDJzKzgg/uX8b5GX9MqsHvhC8ATIfrsITpXX
         hIqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814409; x=1792419209;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/wyxF/Lpcmq2UAtmRiyEA+9Tty5qfE+H9o7MYaoo/uk=;
        b=ykAOkxEQqFzszZ1nvGSl/rfsaxZ0ohNGsETsLbZPRhmUWktlGkMS4hs51CmYUwcr19
         RRMIaKWHpW/l3EELufEcQRh747H6VA24ZrFMeOMgiMLKEFqs1X8mSonn9+IcrJabYYop
         tMpIAsTEwS8UNBkUtnyZd8mr7b/8gN9uwJNpb6O+7tieLUaHStuaQJ7WL+l3rtwl0fAc
         LKNFrUoInDUGN0HqQDqJTkioStrDOFx3t6IalvX9x91kN+MYSZwJk9pajZiLJg+hYLGZ
         vr5gRRrjTKjU5F6W4YVeNzk9muxIi5zpCfWV9GBDVfQWnNeRs1gHRPhov10ApySxtXOK
         7E8w==
X-Gm-Message-State: AFq9FYJVDO2W9p7XkO8kya4Fu68e/3MIujkDiC/+/fmaL0otyC2UILtC
	/At5UdsLP+PwMspnrs0Ku3QRCmUZ9oR50goR2h26KySHwmMU+YMPKpZ1EsVyygHNOXsX9yW515P
	NbwSx6LkKsQUthrTeYc24HmwlXU8U9y0p2gHLIl87NCCiACg=
X-Gm-Gg: AYBFou0WkcyuSiqyjnD5gOzpNT2SVV2PrqYz2AY4IiSUVmk/rOOzMcIZYTReD4pEaYe
	i3oHD9CSV7aanp91LPKjXyq+X2voxQ4Xl2d5FtsdK9b/HgWqFH+tL/wkTNcM4OWq0JZfi18D/dx
	R+XvP/laf5M5O85Fk9mtNlxcc84WLv8RqcUSJvWnxc1xv+2urV6slcmZhx4uVR+IXaWh9/7vz+A
	fN6jZOeaq/FQzIX5xVUWknQGZ8Jd1gh3a5RDQr8Zolp+VixZ55xrCjEtKxVrXPviQIc/lRNtVO/
	b0kBIKrOFYOan0tAtslhgEHeCBlkiy1DD31WKhm4qRE3ZKX1LFZmbw==
X-Received: by 2002:a05:690e:400e:b0:679:5b51:3396 with SMTP id
 956f58d0204a3-6795b513703mr1122750d50.44.1791814409369; Mon, 12 Oct 2026
 07:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010021010.19575-1-jianyungao89@gmail.com> <cfb6c91e-c39d-402d-9f70-4b9bf75d88a1@web.de>
In-Reply-To: <cfb6c91e-c39d-402d-9f70-4b9bf75d88a1@web.de>
From: Jianyun Gao <jianyungao89@gmail.com>
Date: Mon, 12 Oct 2026 22:13:19 +0800
X-Gm-Features: AclHuK9MdUApyJ1gGdLPd016vnZ2H_juAMBnJ0tlWD5ohK8HCeWvpaTvl4Ez6-Q
Message-ID: <CAHP3+4D3xg30cWD4obJq7W5VZhrv7bD-afntiOmyq6PybPgg7w@mail.gmail.com>
Subject: Re: [PATCH] dax: fix wrong error code returned from dax_dedupe_file_range_compare()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

Thank you for the suggestion! I will add the "Fixes" and "Cc" tags in
the next version.

Best regards,
Jianyun

On Mon, Oct 12, 2026 at 9:40=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> =E2=80=A6
> > Return 'status' instead to propagate the actual error code.
>
> How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
>
> See also:
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv7.3-rc7#n145
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/stable-kernel-rules.rst?h=3Dv7.3-rc7#n34
>
>
> Regards,
> Markus
