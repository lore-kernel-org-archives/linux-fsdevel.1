Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A95135C683
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 10:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936257; cv=pass; b=cOj0uA9LZ7G9bO29JXvomZKBYXS2vcyjQslyVDQXIe7898YL20JtZD7qxD2I3L3J+StLeARMQ2+NAfjJ2KVHX/ZgZ9XPUQhspXsUxtVsrUexg8ZDp2XAaupjQHG0Cm2ocFQNDkXhGAafa9XI1JVbnmvgaUopArGhuXAIT3wE17Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936257; c=relaxed/simple;
	bh=zbxh97DfahtmVFw2yx/P+OI0PpzLVE463PD6gyDR+VQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Wu3lKdWY7hUmxD3tvGBzhe3VxR9afw+5yGsSTHju1EYmu03Y1dqrkzccjiC6jTImBB2A89OXGLksVASQtUM5FbMTEPDdeBnxCgxR3ilIXxiwbXDkmpJrNGlSCEmmweO+ArXrUlNtg9bLeaRibGLw+DA+bgyqsVEkjKo7ZOFKjZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcOzz30+; arc=pass smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcOzz30+"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba437ee7f7so1696597e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 03:17:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790936254; cv=none;
        d=google.com; s=arc-20260327;
        b=rxSUSg9RUjjKNXgQYrq5puxE4kj3FZMMLEAAVPh0sqngyWLC7z4POCe9PCi8fQ9yMU
         OUlMRAyLl3Wr4G02CA3BrF6HDzWfC5Ce0X8f7wQ7X2A2oc2vdUlXuLWxhtWsSplMjuVh
         ZVQgGxBPY47Ck2lWO6pI254YK1/TxhsQRkOygX6eVs5l6GzKSFbRH0QFdHSjeAE+/fIS
         9yMUWf6P0wHCdL2xECSgsvmgoNhw3hodkvVj5OE6ueLRCTHvVN+6GULaRIJc9pAiYDVH
         vkSwusZEQ6HvFrmk66dsfWNs7r6j9ie/QUmORkfpFGGu9TyAkqVbgVRqj4Sn3Iu/eqg8
         GYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:sender:mime-version
         :dkim-signature;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        fh=p0l7L6X+X8bd1tkIAbrP210B8ITAXRlx9/SGiWL0ui8=;
        b=Zc0ctzWAodT399U2TAxcJYV3LrH38P+YxWE0UwPP/wwCxTV6L8fHI+NHWupdygOKLR
         omOf+QWXIHrlIyl9euu9lAtXoxJMjQQ2Ml3bl0HC6mo23U30hYJ4cF6BU5unQnQ1ohjh
         SD2RabsRnFsVS5mFFTwKSM5qMfDT8MbudmjDxy0unTsDooBz1F1/YRhbYGom+Jap1kmN
         NkHIbIDwYlAE5vR5JWt9njCTfBJIimWd87MBptUVZrubWACOuXIFaEP0zD63ddg0AI9T
         ARkzciinX5feqqoDlEZkdLW6PKcKNxUGbFAq0FaWqwm880pficS1jhGDFyhNEMD1fT9C
         IhBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790936254; x=1791541054; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        b=FcOzz30+98AQjHVtR7UVXsOk65DwSxleNmU2lZyXW+69OCS8ZlgQPAarHp4ChW3oYq
         Yvr1pR2Mlh+QoKspvzNhNAlIjA+li3LBnxwitlOVvR2XR77Xh1aZYE831FLVJP+nuitn
         hjlpfgpGnWNCKi+t9JVxwDxkGD4sYOh9Ew5FSfEbKs0bgh8BHvrkRKcHMwAOSeOQ9P2O
         LShQ4VVUTfchQWAWWiEofa9S+bIzL7dMMInT01KRxprawGeQe7fpqH61zCulxVMQAUiZ
         xLQH5SL6Q02oqDthD2pqvjXUyj2cB/aLqFcKuEABXvKL5M4NtnD5eBDkzDbsYhm02Zz9
         +hOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790936254; x=1791541054;
        h=content-type:cc:to:subject:message-id:date:from:sender:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2mj3lyrm7aE/R7y/QOz0OagCVKj44YeS0Sz+Yo0D/po=;
        b=yPcIihHWLwMYr+sKn4opMIjgA9Ly8FMwnhjhrlIjQsFwm2aalpy8q9ay5b9IxG/djX
         FeLkORDQ/ABj0yjqiJSdU6/mCKVPQuJDKmyfpPp/H+DGLpwu5hGRAHBya9+G/ZzL5Ui2
         oGbcVO8VZSjxdun3r8lDa0/iSj7IYrdwqq0Sl/033lbM5vH65kQTms7oTdP7Kn+aQcIP
         b2uphKzTLvrlcSI5znv8dMdHUex/BnHDooV27t/nsUknERoWAmsTLgOJ3GDOsoNtqrDC
         gpWOvkvsS6SHR4nYoE71Qb23aeDdmX6fqnABSOhtW4D2Mq0QP9sS7CMmKLpC6JYQQSvN
         XVuw==
X-Gm-Message-State: AFq9FYK7i/Fvl+CquUaXkfmN06Ow1BS1aeX5Qfcm83D96Xd6tSR5b2mz
	e8Gom5/ZEkA+xU2nBzWkvMgZcZYbzbu2ECt2uZM5BLnwr8eekuQgD9LmiVwzjkYeofVAHPT60nF
	st1nAqDSPU3kkPi6vVRxel1RVqu/2GfR5Nnud4oM=
X-Gm-Gg: AYBFou3u+iPZ9PIlZZdhf3c9jnMUx8cSC5HZ/kb8chm7Zw5Qlz9g+aVSslxjcmfFyJy
	/9ooQDdZOMEj25dq0x/6G4sfuwZ473qyO80ihiJ92NQ2OuX/SuKc2K7gPCvocdN3GbuDJGt/Jsp
	xpevKGxbs0vGOF0dNZkOtPjBpa+GqX2rGEXpO1nE+hpBF79dp6RvP3urcm59RlolChSHE4V59Av
	cfLiked7vUCP553JFDAceSI37WBozI44bMYe4b65FeBUN9Dw6fAN4Ar3sWVrn/PBwHrYLlbubcm
	f1ig63GkT8kyWvyU//1NZhC+AHihqhTFh+181CyAry39Ll4F1v4M0bBfSsmwhnD2U8uoY9RbrGh
	zBsZpjdlHKvC4
X-Received: by 2002:a05:6512:3b8a:b0:5b8:e94f:8d79 with SMTP id
 2adb3069b0e04-5bb9bc25b94mr598164e87.64.1790936253817; Fri, 02 Oct 2026
 03:17:33 -0700 (PDT)
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 05:17:32 -0500
Received: from 254448290189 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Oct 2026 05:17:32 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
From: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
Date: Fri, 2 Oct 2026 05:17:32 -0500
X-Google-Sender-Auth: rgVdU-Na-thylIHC_Y0SkBWvGuQ
X-Gm-Features: AclHuK-11oArOlh6vzmbSmxKA7acyV-S_yNov9Vtcz6DICtpbHOmyRBdRUJQ2o8
Message-ID: <CAANnmVDM9VBqwwDKC8kRn8zAP92e_STs=EVNRZtZKgqWaJaLNQ@mail.gmail.com>
Subject: [PATCH] fs/adfs: check name length of big directory entries
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org, rmk+kernel@armlinux.org.uk, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The F+ (big directory) entry format stores the object name length on
disc as a 32-bit value, bigdirobnamelen.  adfs_fplus_getnext() stores
this value in struct object_info::name_len and then copies that many
bytes from the directory buffers into the fixed-size obj->name array
with adfs_dir_copyfrom(), which only validates the source range, not
the destination.

Nothing validates bigdirobnamelen, so a corrupt or maliciously
crafted filesystem image can specify a name length greater than
sizeof(obj->name), causing up to 4MB of attacker-controlled data to
be written past the end of the array.  Both callers of ->getnext()
instantiate struct object_info on their stacks - adfs_fplus_iterate()
via readdir() and adfs_lookup() via path resolution - so this is a
stack buffer overflow which is trivially triggered by listing or
stat'ing files on a crafted image.

adfs_object_fixup() also appends a four character ",xxx" filetype
suffix to the names of non-directory objects when the ftsuffix mount
option is enabled, so name lengths greater than ADFS_FPLUS_NAME_LEN
could still overflow the buffer by up to four bytes even when the
initial copy itself fits.

Reject entries whose name length exceeds the maximum defined for the
F+ format, which also leaves room for the filetype suffix.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Vamsi Krishna Kattamuri <kattamurivamsikrishna17@gmail.com>
---
 fs/adfs/dir_fplus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 4a15924014da..ec663bc12a92 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -192,6 +192,11 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct
object_info *obj)
 	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
+	if (obj->name_len > ADFS_FPLUS_NAME_LEN) {
+		adfs_error(dir->sb, "object name length %u exceeds maximum",
+			   obj->name_len);
+		return -ENAMETOOLONG;
+	}

 	offset = adfs_fplus_offset(h, le32_to_cpu(h->bigdirentries));
 	offset += le32_to_cpu(bde.bigdirobnameptr);
-- 
2.47.3
