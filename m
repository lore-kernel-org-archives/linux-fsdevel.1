Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7123D1713
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654625; cv=pass; b=aUejglQS5KKbbqtuudPPZQfv5cQVu8elYSSS3vbECh4H/GisguWfqcFQ0NbqpjGS3XlnXJ2sJa5I1qduEHAtfnZc2vfiK8EJ9ShGD0ehwNACQU12sghpDieTltVa3/27Kj9y8d4BdfX24PPXfUrbY1salJNvTd4XLZ2Re2C0JKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654625; c=relaxed/simple;
	bh=WF1vL9rONde+7EdvH7Uhhegwq4EwzF5oUtUzFz12QtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWY5P6PBxfGSpYVNn71eEsdl9DBX64J0SaEO4V6qdqjGdn4+zFZxHtr6LRn7RUq6eQ8lWtbI7wjEUeDc9MDowxikudXaBAag0ERVR55kIMlOQGoaRE6xmbUz1NM0jG99EVa5gy7p4MRa25G+rYSNnI04qj6/4kn8bz02ajBqX4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+9vUJST; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+9vUJST"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-68c1653ea0cso2420534a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 03:17:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780654622; cv=none;
        d=google.com; s=arc-20240605;
        b=NumZuYtfwUNQJKpz5khk/T7wGXcdx7xgvgOg4e/jbqAYNBBeijXVd/V29ORRIvV/90
         M74ZMvsIF572xf0//nkuB40nLNow9JLIOVs5PkaE0KGcca7o9qSrOs6R5Vu5OwmPtCyU
         xcuYT24p9uZuTFZxAY4Hju4hQeoryaalKbbsNkXlPqXBtNuYWLic8f9iXVIsyP4CV+Vx
         NiHpwmn8bbay63aLS6RmsoJQ+AVD6/CTck+mtqWP2TNEzTk5Ax3iFUk+GWr7f85Rfr2k
         sZk6+LyphD1vBMOLSMGlywZnRk4wesPN1IylYl9fssO271576PKhdenVMFgkvwAsp8tg
         vg6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bUhFysbZlGjq4fEHkg5MW+w54X1b9N3UpX9VYOCDIRU=;
        fh=ARhWpsT+XnPlUorYc0UK8G5ZI2PFPv8eEqxK5UfY3jc=;
        b=i3UJDRis9XEIeQMcvKdxy6qQ4Jns7sQ/uTBx0LrkCfnyR/L2qt2HpOIjAJ9AlAE24u
         ORIKBBhQ/iPm2rexosHxxwXsXR0gdHlNkaDgCzV5lqNkD3tog3yM1CcYZ0EsOMouQ4kP
         aR//HheGVsd/pTxcBa+U/eHiC7usA27vr20TVS15QnRmHd+xmw4X0veK+n/5Wh+XzHKT
         enFrw/MJRjG0QrATTBMG5fLUM6oy52XZaP9wmf9Vk7Gfte/fMF8OWZ/EO8FMQRCl+mpY
         0CVr+rTuapAqmAUtvnBMPv83iUpyw7F7NKLUk0YaG7PK4czX2oTF1C30ivBWWY2iVDSN
         +68g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780654622; x=1781259422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUhFysbZlGjq4fEHkg5MW+w54X1b9N3UpX9VYOCDIRU=;
        b=G+9vUJSTXWKm8O3eATRdhphA07y2DhvZrPOH5Wq91/zJq3PJ8cEPzEgr1fq/8gYwv7
         aJ46/Vc9FbwjfMQJbWB1t96yDJ+B5KcLpTPQ8nsS/IKtIU6viXvPsEXwTynWVdZwX2H7
         pzW8gCInImWsD9OSHoJNDKi3H5lSgFDloIqCjG0EUJWbtiFA+U0dNyO6DPC+T0Qrof1Q
         +kLPB8d0n/61mS/zIt3XUMS89dBW8OfSkiMBX7u/iofBzqPsL6rM0UWxtUEXcDdxetJW
         fVAG0A/UbzXE9Rj+a/7pY58ESue8ekdR5y52zTH/zZVCOVZfjnQRGQuGvLKAKAt+hZdB
         NfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780654622; x=1781259422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bUhFysbZlGjq4fEHkg5MW+w54X1b9N3UpX9VYOCDIRU=;
        b=DJR+jtTgUqyQ4Gano5NlzhlGPZaWZXKoGQ8KYAcs+Qsmzooq3VDWnQ4rNcdKSK4vvm
         gJCBA0BFnWmiJiqd8oAUPvMjqxJWj2H7BfaTNdPh6NglWQCTOkDOicX1/qeaSKSyG5oI
         C+7Fv5whqeJDOsbf+tE/pGs27R7gJYN5R4lfInne1LehSlqPTWI7y9wPnU8glxylz21d
         pt3IbC5Ju5SY7Eb6AV4+xlhjzSaFNxfEzeVrnVIZhljFHtyddATbAaJWLSZ+v6yzXMcx
         uxSaQPJj+XtSDVvB10bGN49YRoTpOOD6fGLLTYlgruJaVVzFFu8487dmHwtLiHAVMRwp
         7GZg==
X-Forwarded-Encrypted: i=1; AFNElJ9LxT4+c1ZTHTSpl6r27VVEj51DboJemsqzrnuBt7W4nw2eW21WWI9WJcWdoTKb+xDtjAPIhP+r7v6shbN4@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZf4LslA+XFwHWU2H7PoomGJx/neQD8fno3TeYY+KB/4SO3K5
	eTKEHS+MaELj0g3QZAmd6rMwQ6RZ9YhryJEB5m702L1yX6FB0VvwhzLG9/ljKXy9mrCx/vW9u71
	Jh1tN6k0lwtKVhyu01jtQRClsdXA5Fis=
X-Gm-Gg: Acq92OEgmW2PRKPA+vzuw612n6xYrOcg4qYm2VNht34/93yKhyrqHmH8HqP1exEA0gs
	Pw5TYSSIHKmsq2xLHJS+jyxwa6Hi0iExhF8LYqOQADZFdGtOI23z0irENe5EftoT5PAxWE18rId
	d7bl7xfIL4mOy88kt8n/gBDk66z0WDKiYYoFtMeUkjYrjrU+VwNvDT/OyyDNGTQhPNY6xzMYfAJ
	3mQrfI6IE8calfPiBQEQlJgnTvg8ubPmisOqrmbZO+0hU/KmEiwRHXN26iTWuMLod3McJl2RSjL
	eQ4MqYQJN67wCmhTj1KEgdCX3mOKHSKvBveuNZ/trWPP0UlF2chE
X-Received: by 2002:a05:6402:27d4:b0:68c:33e9:bf71 with SMTP id
 4fb4d7f45d1cf-68fa4e18fafmr1527593a12.11.1780654622302; Fri, 05 Jun 2026
 03:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526085801.81187-1-liwang@kylinos.cn> <20260528104208.395757-1-liwang@kylinos.cn>
In-Reply-To: <20260528104208.395757-1-liwang@kylinos.cn>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Jun 2026 12:16:49 +0200
X-Gm-Features: AVVi8Cc1maywQKJB6UJFdpvjKJlWJs4NKrTH45EiYuR_zdidaMKJhOhK0HdykmA
Message-ID: <CAOQ4uxi4F=7pOUJfAJavaCZ19YoaASNssjuADqzUQs24ztLkww@mail.gmail.com>
Subject: Re: [PATCH v2] backing-file: fix backing_file_open() kerneldoc parameter
To: Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>, 
	Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 12:42=E2=80=AFPM Li Wang <liwang@kylinos.cn> wrote:
>
> The kerneldoc for backing_file_open() documented a @user_path argument,
> but the function takes const struct file *user_file. The user
> path is derived as &user_file->f_path.
>
> Update the @-tag to @user_file and adjust the description accordingly.
> Also fix the "reuqested" typo to 'requested' in the old comment.
>
> Signed-off-by: Li Wang <liwang@kylinos.cn>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/backing-file.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/fs/backing-file.c b/fs/backing-file.c
> index 1f3bbfc75882..080c99696cd0 100644
> --- a/fs/backing-file.c
> +++ b/fs/backing-file.c
> @@ -18,17 +18,18 @@
>
>  /**
>   * backing_file_open - open a backing file for kernel internal use
> - * @user_path: path that the user reuqested to open
> + * @user_file:  file the user requested to open
>   * @flags:     open flags
>   * @real_path: path of the backing file
>   * @cred:      credentials for open
>   *
>   * Open a backing file for a stackable filesystem (e.g., overlayfs).
> - * @user_path may be on the stackable filesystem and @real_path on the
> - * underlying filesystem.  In this case, we want to be able to return th=
e
> - * @user_path of the stackable filesystem. This is done by embedding the
> - * returned file into a container structure that also stores the stacked
> - * file's path, which can be retrieved using backing_file_user_path().
> + * @user_file->f_path may be on the stackable filesystem and @real_path
> + * on the underlying filesystem. In this case, we want to be able to
> + * return the path of the stackable filesystem. This is done by
> + * embedding the returned file into a container structure that also
> + * stores the stacked file's path, which can be retrieved using
> + * backing_file_user_path().
>   */
>  struct file *backing_file_open(const struct file *user_file, int flags,
>                                const struct path *real_path,
> --
> 2.34.1
>
