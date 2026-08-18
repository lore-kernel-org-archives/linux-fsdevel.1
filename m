Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5917442B39
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044961; cv=pass; b=V00NKZevS90YEM3AOoqesnGMidNONckj6eZOGl8Wwfg9uToxxAMlwWJwJrSC3R0NVn8OHndE38xRJf6wKtwg/j/RDW+jfz6FTk6pXGysaXS1aW37v2vG3cBSczHVQjFN3bH3XIhlxksK4P7tBK6qN+GIq5mwvwIFDWkPp8soIso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044961; c=relaxed/simple;
	bh=QOsIj7oHlKxPR+bfScX6z8QYgUfcPjn6GIkbh6a+ne0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DAykj7ADLdUEtb8+Oc1rHwA8ucAJGePIW/Xw8bjHYY+QjPIForCuKNy6NjTudmYcDEONO63909rIP6K6GVCiYwnJKC7OA8RAqKpmF8Sw6OlaoRcZAeiceTx/SZ4sVoPF4hOO7CV8R3R32XYcGjE7TIoK17cwi4n8IvCP/PKOyF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZNYsfr+k; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZNYsfr+k"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-52b4e988c77so28442011cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 02:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787044958; cv=none;
        d=google.com; s=arc-20260327;
        b=ceNmYADwFoTN18zadhVsng1RfZQXBQT+9DaBG+pRy7gD45dfEURPmSUr9qmpgyMXTi
         nvUDdR9O7/ow+Etr4EUD19TN+dPoCOoR/lYdFc2Y+BUhrFNmmQ60LGupIBD6aoUwZUzd
         OG3x8NDf/ODf7E5eYPRMZYmtx+ww+lwbrfqUT6Lo+ENvsNwYHg1i2RreMzcbCWtGo2ju
         eWQeSVYTu2+O1F//MdFr7xEj/cYRs/Knkx8p9l/B8B19FZOhqYrD46DWp7MBedVrWQcj
         JAluDmBWWOaq4OKxICc6ICDlP9woCbluGsE92JlRd8C47P1stEc/2IQDV4/qrDsUIEMW
         yKSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QOsIj7oHlKxPR+bfScX6z8QYgUfcPjn6GIkbh6a+ne0=;
        fh=NFa8wxtfg8MD29FjCpngYA4Jo29VAV+FZsON5Zn/9ZA=;
        b=oz9mnQuAeaxXZ+j00eVULq8bln6MWwBD1ZNQ3eogIB0zG2nuXLQiHR2QI1wL4v1HZy
         mhy7PWUBxWxQattLSnunqS/3gnLAjjhbFdbK5H9WTUG/fdto1YCNdx1E5KmP6utPix+j
         e2awvXw/q3ITejMWdO7N1sSRvXf2oPtmdhy2K1EVun98IUU8TsvDEcevWg5RsucrNgzC
         wcUG7ZbrS2B58rimPO5ralEvZ8X4VqwY+JcsPcjuG5msIJ13ocD/ae+ly07I+JxzWm4l
         DGLsKMtN4Auc5BmESSvVoNWGKIRRt8b713O3cXE9rBYj21Yd7KF/zEY5izbbotDJ0hhz
         c6xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787044958; x=1787649758; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QOsIj7oHlKxPR+bfScX6z8QYgUfcPjn6GIkbh6a+ne0=;
        b=ZNYsfr+kpTdYy+WWA7t7UG47Ii+j/rajGjZcAlHxywp8QcyZrdSA7lKe63itNJ6w5Z
         OmuTeU3dimtzVAy2V1aP0XKue4DTzfDuXwpZsJxETuzk7EMHzHezhLrgyPCp9a48BFFH
         67tet4Dz0Ls/BurD35c8tTJKGojmT7eDJIIvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787044958; x=1787649758;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QOsIj7oHlKxPR+bfScX6z8QYgUfcPjn6GIkbh6a+ne0=;
        b=MIkALC3APRh4DY4YurRi+z8sbNP4vEy2rMSfFiA+sM4l257M1xZMhWisZRUtL4YR5S
         kxUiKkrJ/HB8lOEraDt/qn3E+lqiTPzv7o56AtcvuDx2I+G/VxGl4ZWggLcSX9Psn5m2
         aBGKX+cpaj1ScuITCnZETXPyqoofR3yFi9w8g5/GZB/AfIoAVIY6XRe/hcHiqJz7SJ5t
         XOH7FIHnXFC2TzHelQO7NclA7jcSNGit/4kT7f1XbVtp5m/frqbWljAFg6FE08Bg2vjO
         +sZyFb5/WZygwvcsngm+akjHU6pBjV4LB8fmB11KA+dqdXQg9uG60kkrFX8zrMiKD5uw
         m/Yw==
X-Forwarded-Encrypted: i=1; AHgh+RrmmqBNu1c2twSZgq8pt6eA+E8W1KVtQzsHObuKj5gPiGN+kVLrNjqqcp3jPIX2JD92Uyo/6pe+4pbNYboK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm7r1untM3lTv+V22FPhkTq+4xTfWGw6qygKTYCd77K++piR6b
	a4JMnHYBIF+xUP/a9THngrw5LtjY9Q25VH/korYz4x+H+LVnOu50gU4jlMJwOFSg8Ld8zGCl+oj
	eyp/VF4VtsqMUkHtbgZTCuChf/9x8w234TODgov8PEw==
X-Gm-Gg: AR+sD12+0hEBZ9Rt2W1xVCeY3rblab10BBGTDt7oVNAU2RbqiwInO5cWHFUL9nbDKyH
	DB6XYq1XhF3IrK5SCuKROx9/Wv5qdhmfLgN6FiypWe6mxZwNxp8r9X9KUmNAL2mNE5vfsjNryN8
	D/hEbogXpt59L8n7NfgDeU2D7gmj/C90qBlXln+BWnwJnPNuvAhrrhR8jRDuoJ/gdtgq78kims7
	vT9NYF5m+2ndpFxZKOuTEK13yeXZ8YjSO3YdRYDxQWV6cxdVTeK8OrAvVJU1M8Sl1QhoMgYQ2Nf
	QJqcUbApRG/UvL58Pj3McgKPOMX0aOZ5RSHRwwkspWdFVD8v7OC27AMWD0iK0M3lYK7T+iQpPLy
	O
X-Received: by 2002:a05:622a:1790:b0:51b:f640:2a4f with SMTP id
 d75a77b69052e-52d853bbb8amr318791521cf.4.1787044958684; Tue, 18 Aug 2026
 02:22:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808041339.1687459-1-libaokun@linux.alibaba.com>
In-Reply-To: <20260808041339.1687459-1-libaokun@linux.alibaba.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 18 Aug 2026 11:22:27 +0200
X-Gm-Features: AcwNN1VItSWEE7RBF224CaGW1gStvgzdjPq0b8SJPr6i29MjpJAo-VJQ8ZFtyHg
Message-ID: <CAJfpegs2PwgkPNVmHwpHKJ4Bs0R+Qw87xEcCvWVGSgcZhOWPpQ@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: check for NULL root inode in fuse_fill_super_submount
To: Baokun Li <libaokun@linux.alibaba.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mreitz@redhat.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Aug 2026 at 06:14, Baokun Li <libaokun@linux.alibaba.com> wrote:

> Return -ENOMEM instead; the caller tears down the partially built
> superblock on error, matching the other error returns in this
> function.
>
> Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
> Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>

Applied, thanks.

Miklos
