Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8418B26F2AF
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 03:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778296509; cv=none; b=FbBby/4qGVim/UiMriEkseBhqOefVudT8xpQDTi2XjSpCeGHeAr1rROKqNH0D6PiUhPGOAi6pl7RGHVjkPR7f8evuu3J+UElV7iB9lfVamnntC5tBPFmXAsKhQRR365PmTzkj+wbqMIVZf7g3RmCUs8yPRjiLvhNAPidw1X5MSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778296509; c=relaxed/simple;
	bh=CsIHYRPeAz86j+2Zu0I/sJA7IeP3CchYz6U52XPl3mc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBBlnLFTqow8Z8aJCeolJizBtLX9/IR7zXQBW9hWDC4w5pTK8Zk5tsimLx7fuCa9UU6R41kr2AwFnTons+2Om7RuNbttGRqRFZjy9zpz9fiKIjZ4Anr+uDpZMvYKZxk52ZMX24nFR3gPPJvA/pEzgZURyzexV8k4EQuAjKQzVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLDQpki2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLDQpki2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29759C2BCF5
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 03:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778296509;
	bh=CsIHYRPeAz86j+2Zu0I/sJA7IeP3CchYz6U52XPl3mc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OLDQpki2j4LWyOB/MQIV4U9R2yRvVpirwr7+KtnVTwjxlQzFe2bUt478Iv5z2Tdq+
	 57GI2JGZ2i6Ubuj+owd8+CiOIPZFvJtxED5sd0REf73Lwm2sXO6/ni5w8+L2zHGNYj
	 eVsJ4lpPgmC5V16lnByeqDWBu/Q/uLisDAbNFk70y9WwpOecrgvcJ7i84UuDbRH+zd
	 f1dOFmMiHRsX3kLg75eaVlgD23KC0gZLHYqhe7LQi6mVP2FHyPhWwEBatbczaM+cH2
	 NR3gGP5ONfEZ5vqNozweEMqXSqrGBE+yPn5FihVW5HHkRXI5tH8GJbojYZYKnki1Wq
	 isnixUtkbDgIA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67bb5ad91bfso4614959a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 20:15:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/2hjGSNN0O60iiIGowOZbPr7VbUk5UNbcRPoDKJwPql111hRI2K2A2E0QTPbdkrtKJxz58/5JCxgZlHj7t@vger.kernel.org
X-Gm-Message-State: AOJu0YxSr9fCDny75QyrZxjUrdptfuwEVV9KIF9sStyq13UTwBIHFOic
	RYqaC1ojWQ9Ik81OrHxw69Bq8PA2hHtaS6MZfotbABj/Uax6i+/e00d164eCoQGF9BDTQidll9I
	NQwevHwRxPUT+6GsDaei8nOD1/qxYO6E=
X-Received: by 2002:a05:6402:5214:b0:670:f828:bb1c with SMTP id
 4fb4d7f45d1cf-67d63d7ee43mr7653806a12.3.1778296507726; Fri, 08 May 2026
 20:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANFS6bYFbn_z7f3Maxze0GsZbsHnV7kS=q-gLw0U3Bwf+75s_g@mail.gmail.com>
 <20260508072934.75939-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260508072934.75939-1-zhanxusheng@xiaomi.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 9 May 2026 12:14:56 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Ph7W=uHEE_OjMoG8yvKwY+7qR_46KJejCJcU6xBWCCQ@mail.gmail.com>
X-Gm-Features: AVHnY4Kpxg6m5NjF1LfM24ift9pLRsEo0zJwssh-E9Ha7kocmq2EhwY1vHhQjIc
Message-ID: <CAKYAXd_Ph7W=uHEE_OjMoG8yvKwY+7qR_46KJejCJcU6xBWCCQ@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix missing kstrdup() error check in ntfs_write_volume_label()
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 4:29=E2=80=AFPM Zhan Xusheng <zhanxusheng1024@gmail.=
com> wrote:
>
> ntfs_write_volume_label() does not check the return value of
> kstrdup().  If the allocation fails, vol->volume_label is set to
> NULL while the function returns success.  A subsequent
> FS_IOC_GETFSLABEL then returns an empty string even though the
> on-disk label was updated correctly.
>
> Fix by allocating the new label before taking vol_ni->mrec_lock and
> updating any on-disk metadata, so an -ENOMEM from kstrdup() leaves
> both the in-memory and on-disk labels untouched and consistent.  On
> success the preallocated copy replaces the old vol->volume_label.
> Also move mark_inode_dirty_sync() into the success path so that it
> is not called when no metadata was actually modified.
>
> Fixes: 6251f0b0de7d ("ntfs: update super block operations")
> Suggested-by: Hyunchul Lee <hyc.lee@gmail.com>
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Applied it to #ntfs-next.
Thanks!
