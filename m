Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E43890F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787872134; cv=pass; b=uA+bd0oTtLtr+cq3yWrjmK+m/LLQyYjFmVrrZEOzH/CZUGghiWXPq2AwnAn8S0OpNa6VYI5sdELYoZHuPmnOXzNcI2GVRYvuP1Ks4sYrHQefZWGxd36W8gj0CC0K4PXMbdRkySjeNbtBOvLnEdfN9R0CRCFPamD1qX9ddA1XwFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787872134; c=relaxed/simple;
	bh=QE5r8Hefclm76uVhId1kbMmsj7Fs1WnSDJQ72lFByhs=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=DqNIkppfVi2lZGJV35md5nI/2nPpB6mmVKpgbor+SOf0+ymh3h3ehBrYIi/ZdLxRxdvbCblWS57lXFC7YbZX4ORARGmXyZxEtccSUhfsoYLxvni2VUm4NaNPzqEjYfC7XeMJSWaeUcGh1FaWvKf2IBQ1MVPv4CH+R/26OtcT230=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=MzrwqrSM; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="MzrwqrSM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d71a50caa9so5035145ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 16:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787872132; cv=none;
        d=google.com; s=arc-20260327;
        b=madwuuwVzgK0Mp91z/TGj5cl7UgvGH7aVX4cUS76Vhnx2zO5tHgMZIaCizHYwByz4a
         jzYFcr+TjNOcxqkUTTtA7lnHFrk10xIoMKdC2XxZQqBVoOmvR7FWgzF30u0LsGEP9g/J
         WRCl2Ukmn8X7du1Qqt1nwY2aikrvsiCTwfUFgN8VUHkbwK1J6Xdos+HwX0o+3oIyokBk
         cmWRtI5QVcm2JNixq0XQYFgz1HbacJvso5f+vHLmfmWqKsv4+s277YlO0Mi8ByOUuVM+
         6igE/Rvq9v0xv3cWxllmM6qKeAjcovNwRLOxKBL+beHRtigf6SJ6Lol9Vf0WMkKYrhoX
         XJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=JdtPX2uer4IOAQhgeqeDxfMKbOSrBGipE39HlDMAV7Y=;
        fh=F8x0QnSZaNBHnm9ieWc7C+1SQol1JPhGL4daFbNR88c=;
        b=VpI9473lq5HNVx+MvUlxAmJfgtRtWTjSFU4TQe8PHfz8iTfkDlsRlw8++nx4NsrVHB
         Xuu1bwzqPOJYrIu/boEUeei5VEmu11gw0wtkoePHPvtH9CRtLdCuKJpQgUajlyYgKVR0
         /GDy+vE9aTXWzFp+XGsNylF/gbBJwIx5fDOLYBA04odV1ZwBKAjyniPhRM7nJLJKy/3I
         hxGxVTBl7pzRk0EB3C+QZ2cia/iVyN5X5saiRRA9+OmIqGx0eRseUB6Fqio3wFqz3yIm
         O+k7Vmw01QYTDbxHcaSEADMfJ+S6cH1uvOhUe3dvb+8eTWXrb1hLOnsP3E5jDWsc+NTw
         Kq9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787872132; x=1788476932; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JdtPX2uer4IOAQhgeqeDxfMKbOSrBGipE39HlDMAV7Y=;
        b=MzrwqrSMJuh1MCLtMwBFoLtEj8HIT2tiVoE4pFY5qBN/YJW+qjRRpA3WDjqyrFc+wc
         uZUGzc8k+VHe/SA7RE2JfnKPh66Zg8N9SPLJrkb8Gi1gpvscxjMZ6K1E0hBvtsEmlp7n
         +NBoWrjFREqpUAixvJOHJpVXz+8/8sh6CIWiPiVQEEk7XGezwJTzqmHullWeEL2UpMQR
         YDlD70oq+N+ZDrU9E+0XlZ3018QL0nOPrO3TBYP7etEp4l1cOO9ldkSltDUWh3RVXWhZ
         8EMQGmNeR0Ya0Ma5fivmIpPZdClK/audSCbdY/v3tLXJ8UDm1dpVsvhKuJJJ6Gumkc3Z
         1dlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787872132; x=1788476932;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JdtPX2uer4IOAQhgeqeDxfMKbOSrBGipE39HlDMAV7Y=;
        b=KkQ2eJcR8hWEX5pHwPeo3Nag+CSzrkXDnPugNS8opHbahBUpu6tSKUs69VUzCSUxKu
         gLjMx2rZpmfFCaeiG3GCuQL89RoavFPql+AFcDeQx5YtSu1uIK+o3844pROBz+6L/NyC
         u55jv7D7HbLuPclSf2pLl1H4EmRTQ4U4ZXaHxoZYUPkPSehq6zYOKa202NEpxbvLROUn
         NS1XC3qW37vneAj3eSp4W/EN5uIIXZWhJZy3KA9Zj+hMx+NMr4hOC9MhtYlYZRihOsGd
         V/l45++rmzQtFYXCzVhil3qB/0Afp3gJ4dy0w4yoxdixUAc/CiUq0PrERERWjHqnDnuB
         rz3Q==
X-Forwarded-Encrypted: i=1; AHgh+RrkdMeu1FUkCqXl0bxKHClq4iDsxAJflOejHITPV66N3DOQ7MVWQfhYBczSQNc9iU/5fieDG6PFmUn/D0Ry@vger.kernel.org
X-Gm-Message-State: AFuF++kORjV01KSViKUkwpzt6WoIiaenWifwTaOWfw1MvdgCA9bdfkwm
	hmvrasDopllDJpdnVaD0QqZFljTmMUN4el55AY4kN0gC78yCAAz2kiIrZmmEUaKx487mdoGtPEl
	TrBCHfKJIZ08gBfouebtpPIPrOSiC+Ri1jRXgWLZq
X-Gm-Gg: AR+sD12vxLeWn74YsXnVvlrbYx2btxCbDRAPhjg1rkV76Bnqvwb9j02xojpLV8SYfIF
	Uw61wseQ78Xnpv7+FXeLB456BFFYankhxZOSvsZbk9sW1p5JVtpTuZ0/pCnUppyglTXx0bVNd9E
	cjvhMPY0W8jPpPkNdk8H5O5/12rH8XEfjDf5uMyWGwftACSkO3qljS+6A2BeVa3AlLJY71VAN/x
	vAo5eEhSvFiEycqVhfTvPxhFhqwVQ42XgWhmcRWfOZhmZyVkWc8QrwNYdYranqDg/iGA9zrg06i
	nNxY2vvnf0BDl8Kvg5V+FjB/KB2fGWeJeklOTMQxKEYF65spQnbIoiavMXORQ7bOHLKB4zQZyjo
	WIsX9kgpux90K/cW23YUE7OX89BSOQlVe
X-Received: by 2002:a17:90b:39ac:b0:38e:6f90:eabd with SMTP id
 98e67ed59e1d1-396d0ea5451mr3577011a91.5.1787872131206; Thu, 27 Aug 2026
 16:08:51 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 23:08:50 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 23:08:50 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 23:08:50 +0000
X-Gm-Features: AcwNN1VbtQ_TKORfhlFpdsm_n8MBcq9xHZjdMpqeltBevAURlMvwXQR-2yvryik
Message-ID: <CA+0ovCjUB=g+56ZCrT4MPfWjqBJX_CO=vfp12JLOrh7B53uVWQ@mail.gmail.com>
Subject: [BUG] ksmbd: use-after-free on iface_list from the netdev notifier
To: Namjae Jeon <linkinjeon@kernel.org>, Namjae Jeon <linkinjeon@samba.org>, 
	Steve French <smfrench@gmail.com>, Steve French <sfrench@samba.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Namjae Jeon, Namjae Jeon,

While fuzzing Linux 7.1-rc5 with syzkaller, as part of research at ASU's
SEFCOM lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/117-ksmbd-unlocked-iface_list-uaf-netdev-event/

  refcount_t: addition on 0; use-after-free.
  WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110
lib/refcount.c:25, CPU#1: kworker/u8:3/9983
  Modules linked in:
  CPU: 1 UID: 0 PID: 9983 Comm: kworker/u8:3 Not tainted 7.1.0-rc5 #1
PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
  Workqueue: netns cleanup_net
  RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
  Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 db 45 27 fd 48 8d 3d 04 03
1a 0b 67 48 0f b9 3a eb 4a e8 c8 45 27 fd 48 8d 3d 01 03 1a 0b <67> 48
0f b9 3a eb 37 e8 b5 45 27 fd 48 8d 3d fe 02 1a 0b 67 48 0f

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
