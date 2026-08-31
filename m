Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4A3559C82
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 13:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184037; cv=pass; b=KmDTDJCSEl0hKqKR9mkK9G5goGbD3LgcBbz3FvOtf8bnMwAo03os+oSE2pJ04yblfaSV6dbICWV8zZ4L57zPMBRhhe/7YBcrbVu+vVxplTh6dany15fF/8CXhje8p03flvF3dyY5Mmh15/2ptp38jtXCkv8Evy+S/bkBmxQTXN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184037; c=relaxed/simple;
	bh=sJI2mOCc7tznZH1xeE6WUqxrzQLAatMXruEgFfzLUks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSemYAbHf6PpLov/O1d0SNFLCk2o3mhw5vI9LuGPP04o5JlALb9osOc1L3AKsDfbTiARNsClyrixAqPUaP3ZkLRzff+NnKzUZ8EW5m7eELcOf82yz1f0l33oew6bAdOIYbkVOjofrR3m5maifZkx1UVwnOf9nh6+Pt2HpRSvEPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRp5bbzk; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRp5bbzk"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-46ac530ba95so711704fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 06:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788184034; cv=none;
        d=google.com; s=arc-20260327;
        b=s2zag2tTPHDu0y6vtYiNeM+lb5lrmhlFGrOE4k4nGfl2VAaCB6jjciPRt9RWlpbugI
         gkk/zAR3QtRi34Otoj9i+gYxsoip+CI+FqlVpK2woMsZ1ipD5KOPxOG2GdlNOb0QAlTb
         EqL5t1x3aDIZKR1Z5pXnwXbhWcy55keZ5jgBFm4J9+jIsrjHMpz8vpiaFftIXk327quA
         /JIVu7WZg3VQlNnhMfaQxwjJ9jywnhts8/LqZaHHEDv3aFXn74wmBOAlvz2BDAbHdALR
         DUh88QSa5wE240YZ5hzMUFniodZoovLrCDKv6bfozSOfWgnW+w8I6JAHBLnQPsMLCY7V
         ISOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXdZhCAXl/YPLluX+b217oaIUS3C82lBDYKPatd622s=;
        fh=3fTJpAuKg1P45JFB6yNLq7Mhfdc4tg+2/Z2Sv53udpQ=;
        b=syfqETS36EU6Nmdd6F3aWer/xJ1H8tda7SBcTwjZczev5/tjozrlKsvMox2Du0u0SK
         l4KiMWqLT8qO7gO3WDyWLyo2g7nHGU+vvcHzB3u6QevQ/5XPo6bopO2kEK58aHGBrTf8
         JRiQefwhdYxtw5LpD4lWkHte9otb2mTAElrYYIOPV2NpBO7OnSOQnp+shCJEOU/7/4D9
         1BoEqahqLgewXzfGaGq8M/0LeS9vacfA5yuX2xfSgQ6spiH3afKbfUxbRVT5QK/kGlgl
         VUtMYghoSaIhclgAEkos6Zm+ESuR1v16RQWBENRPNY0+4K+G7kTPK8SdTO6lanNVLCdF
         eM3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788184034; x=1788788834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZXdZhCAXl/YPLluX+b217oaIUS3C82lBDYKPatd622s=;
        b=lRp5bbzkRDRp1K+S8y1GX09DnnKFU7PE1Gbf6wVUdRHBAavcLK4s2XmKkW5zbMKSUK
         k6b2AzuuUC9a7Z1nvd3ZtIdvJdHipXL1J/VlYPmBCx1NiiALUOaF5dPz/a496trHg7fP
         chBjZyGRuV3NAxUkFIASlQW2GilvxdaVd+N9cTSaGr6H6Xp85ws7MyjeWL/sI3eB5VXc
         /7EcPZd2gmttVD7+Li51Rynu7ka0bZ/3j2Q+422slcn6kD7sSyGPEzjjpp25mnyuTqt8
         L2eMwDUbUrNAhy9+xgz5EAq0+G462Ra1/xGYwnCNWRb/7Ds9favOJtVkBQJYNin17pzh
         IH+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788184034; x=1788788834;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZXdZhCAXl/YPLluX+b217oaIUS3C82lBDYKPatd622s=;
        b=jyOpKn2OVA4+GUEewygeq9laA7MMUtl9oIjcbEeE8gvV5PweYebgJ/0HQl9/9birJs
         93GtAtVsCP7rPMh327Jg+E5FFuo8Nl5xhczLW5ALlTtzYHqO+4gGyAJu6e91/DDbQ7Cz
         xhSDTY846JsGmqO3SOFAvcEVIznEf5N7VKIry/gqVZX+OOtKsXRrU9YvE57cOPatpEmA
         K+fWWZCqL9j2d5l009v6k4I/8zwTOoSeDSawtBuHmSiVTFAqrCTNXN9pJ7OkzYbZIXZM
         PXmJZ4p5eQm/0/C9xqyTfgSX3Nifn/FwH1JFkVfgGEVlefCq2jBBlNdcbS1lfHBxW0RI
         0aYA==
X-Forwarded-Encrypted: i=1; AHgh+RqBkBmd3D+H6WuEGaraImnFu//8hEqGew8esMOCWucKm42+9AxrXuplJ6aZ7lk1ay9y8qUI4H8Mz9KKwJpV@vger.kernel.org
X-Gm-Message-State: AFuF++lVDXugL9OSC3j+XPO3GgDVGJBfU22O+pNug1gQcqk3UAOxNlgF
	oSTXj027ubTLQScSR9h0zP/8La0CdZk0pvnkPWSNLmZkHpC5JOC0jXX5byxwmm1HB/PXOIBYH/g
	HJ/tKYBYLERW4fWO36TL3xCWajTJNcZc=
X-Gm-Gg: AR+sD12Yw8lKv8kFgZ3AghVveDEuQwG2WRGlvHY/FhpL6h4eNLUwEcVaizsZy9OOPO1
	zNAIdS4HvAuYiJKKv3hjjvAD5dNICcHZqq+LDllto6i5BI/Vzr8OGtH9shOCXDZG1meW/4hTMJL
	sRZhUdntVJMMqSuuJJb+J++TN1vixHnRyXP1NnS/4zJfBDNSi7LGkkjm5NZPtFxC/B0VNn6j5nE
	B4fLk7iAFVuBSnKWWjszjpqjf8BzbtqieiUTO7w6JHz0K/VASqUWJqBNAcnpH69FNfUVZBAtIob
	zIkaPnpjRa0AVs5K51siNDdn6oJIAc/eK+uUZFH291RhFA==
X-Received: by 2002:a05:6870:9d94:b0:46a:9a34:c571 with SMTP id
 586e51a60fabf-46af57f1aa7mr1054584fac.19.1788184033715; Mon, 31 Aug 2026
 06:47:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260829213256.51527-1-kmehltretter@gmail.com> <20260829213256.51527-2-kmehltretter@gmail.com>
In-Reply-To: <20260829213256.51527-2-kmehltretter@gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 31 Aug 2026 09:47:02 -0400
X-Gm-Features: AcwNN1XH17mTpK2KblerbVrKlCve1RclfFZ2A5wUG-rwX01P42n-jv3618nmM4k
Message-ID: <CAEjxPJ656tz7PZuVfKU5W6tBU01-Y2+EoD3wLQBanDnj2CbXng@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selinux: preserve user SID across nested backing files
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Baokun Li <libaokun@linux.alibaba.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 5:33=E2=80=AFPM Karl Mehltretter <kmehltretter@gmai=
l.com> wrote:
>
> SELinux saves the user file SID in a backing-file security blob so it
> remains available after mmap() replaces vma->vm_file with a backing file.
>
> For nested backing files (overlayfs over overlayfs, or FUSE passthrough
> backed by overlayfs), user_file may itself be a backing file.  Its
> fsec->sid is the SID of the mounter that opened it, rather than the user
> that opened the top-level file.  mprotect() then checks fd { use } agains=
t
> the mounter SID.  This can incorrectly deny access without a domain
> transition, or check the wrong target SID after one.
>
> Copy the saved user SID when user_file is a backing file.  Keep using the
> regular file SID for the first backing layer.
>
> With two nested overlayfs mounts and SELinux enforcing,
> mprotect(PROT_READ) returns EACCES with an fd { use } denial against the
> mounter SID.  With this change, mprotect() succeeds.
>
> Tested on arm64 QEMU with a small BusyBox initramfs and a purpose-built
> SELinux policy.  The original test was also repeated with Fedora Cloud
> Base 44 userspace and gave the same result.
>
> Fixes: 82544d36b172 ("selinux: fix overlayfs mmap() and mprotect() access=
 checks")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
