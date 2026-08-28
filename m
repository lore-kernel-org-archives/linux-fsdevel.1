Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19533C3C1C
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895952; cv=pass; b=PqnHe5F+exdeztW/rcfux0XTed8Sl3DbCtlRcG/sMbOmlG5NqEZBMlmw0jq38WQqIABoOJPShXTSGJfb4CdkJ0i4DDgqnRXA4cOZmdOQuoaM4A9UVpogzwcihqz4r+ZfQWB56KhUCltQYi89EKeRY7d+y3tai81NXtxtpNX117E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895952; c=relaxed/simple;
	bh=cxQhQPjuyAaqzyCBfonmNYD1ffbCWqyFbRydf8j6LnM=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=RM9On6bzGZ5HdGdOyNV9reGIgmik/8gB9PoJXdSesZGjOEPD8hPQx53vMjyDHL6E/JcibSiVlFO2XIbRC1r5iZY1M/3rPm5j92nZDp6hTAfhgvszZJUWgKmmfTIrLNMOYod+2HRbJvw+NXxG87dHdskHn+U4PWOUU9USgBeENvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=Pv5hweAH; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="Pv5hweAH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso570974a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 22:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787895950; cv=none;
        d=google.com; s=arc-20260327;
        b=iSVl/WlcJAEN3HxFCN3tipb+1vVE9wtNGmjm9Wnq6v3G48y53Cm5ARScf7VbkAhYeQ
         5s9JLfoWUYtX3FVQURL9qM24IhNaUusWyDBMdpO3eRoK5PLhQRfdaJKFBy5dStp7F1gX
         j/YIr7QCPtB+3AuJhWTb1qoKl8XTYsYTNxpYAfGzXeTa6hVwh+yDlOyw9LuggQ62eUJR
         LSpfyOCG8uDrwlyXygEMvmVbahx/cpXOtF/as/8kanv0pQ5cYueVdI0FfPB9oASuTvMP
         xr58stVNf4X73x28pYn0F+griVxvvKXBeqDolTAq8pR+JCMcpeOmpOMSS83M5zAMR/PS
         GsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=coT/Fcx2iJMJkuY7BZDQNvtb4UWlhVH/ROP4nEGdi94=;
        fh=HGR05P9WxNYzoyAqlKLbDGxnFfJvz22uMBuzlv6qFKs=;
        b=CShUCrMnAt8pXmkvgJYXuEb/MO4GxEceRgVFCpN+5WbdyU3pzbGTUvhWxxZlr2GjCG
         Wk1E0Gc5PUz31MGtVpcnuOdc0zfRLP1iGAEluD4LKDr5mzxXP82nSGIiyhB3vtscvioV
         JYS6jay1LawrhiyJD5Clt5bJyvBpKJMrgjbTyHwFqF48/+tlKPvSqo1DCWItSSQMdE2y
         fYLfaWriiDRqll9HhNYX5BFyE4oH0P8rcXxlPKkRKH+eiPJx8ZLIpFt7th8kWqAAe6eJ
         nd6KbUhcxoFlX2gss7gMHTQcxwZ05/XzYHt9sajw+Z2883LfIp5RsjiU41/3S6NugRdu
         zbJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787895950; x=1788500750; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=coT/Fcx2iJMJkuY7BZDQNvtb4UWlhVH/ROP4nEGdi94=;
        b=Pv5hweAHgzKLOxEVzBT2oWV/JXnZHHno9mtmCRnst0pqrWU/S3iTWHM3d84Em1lNEh
         FIrdHjPYnq/1XnN2q0M05vvEI1Z5oqb87aJI6XszCVc2cjl7DOJOt3dY5GWHhQIg3x3Q
         U9WqOvWyu46VYH6ngsNUDPCffGruIDKu9hlAPd7tBbRSIBodRjAg+mYsAQrkB5Nh6awm
         au0YDQPjZBZVeNupudLSY8HUCQKy84j/A+DX7YvwZVfMeg+uznabfs2ofu4cf5se/48w
         /YoQsPxKUWj0ejl6Z30w3cSaDVVCkDF0mJH01EifwpczkjpYEV1LEceD9LZWFTQ7GZR3
         wB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787895950; x=1788500750;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=coT/Fcx2iJMJkuY7BZDQNvtb4UWlhVH/ROP4nEGdi94=;
        b=W1S75VMuz3ZfdyW73NMUVDF1qhFAWwKPQdH4aTBETQn2vvkEGleytamyELfEvQA5X9
         V68eihEszcJyxAs3vfcjhCA3s6h2SjyngrnV0/p30KiJz4G2gvHq3vcz4tsGWxDyOyd+
         AbpDfKGs/r9LKAgv1BtvddEu7XcMaO2SoltxPVuuiECL+fHuvYL+gIjCPPqdVlBo0kum
         8gRGEDhz6gAnBE+2CIipyBCmydIAdZu+z+/g+6KFA1Qv4Pydo7hD8P/uFWap505UAy7+
         AUUcP4CEGtgsDCF7km/Kxrvy7sn0LFfRDM77+vAC+WRK/nEKVYiUv8t4BXCruRJfvo0q
         8SvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpO49zfgYYA5O0iuhlcZYnDkx/vtK6NttX7UXYOeZnrz7kexwdXjQtADPpNBWo0ucCQGFcQHDn6SOnATajL@vger.kernel.org
X-Gm-Message-State: AFuF++mNNiYCUi+V8Icqmx1NIOSzY28zi6YDqqG2g9TnEx9GGzG/67Lp
	mmy3ADq3/ZD4XzIpYx4knWwSUaF8sFKiReeysP2oHnQdijlg6IXGW7Nz8G3vHFqKVCfwgM0O7tm
	2fh85aaqMb8gsY9Zj8cfD7PQbbaJ/cVfjDEpMl91k
X-Gm-Gg: AR+sD10mXJ/dHJT8g7lxcjY6dGq87HoTgHcekr7bbzOPyPFus0ml17HoFwUS1QJErX7
	NmwVkTtr6oP+WzavbNnhEj0eCsQYE5oquDCiudVbDGsa7BFsb9KzlbUH4sbX7m0TJJyNYw5/fK4
	mvjsW5xdfmNA9cVNGQ7ZuuONwIdZwZsfyefzQSAmGfAzgEHfNs0iIbYqzHAWAz/rQVy+f3ERqIi
	nKuScWf22zd4P+ftm3ua3R3n1muf3hz9YXZJIE+Dp+6ViXETJFMyBO6oWOnbRM98l2S2WVXXSoD
	wjArTy6hQMjxJL+JOiSGAdhq9msGPYou/W9KTlUxVFZzlJ4N8pHB2A/Rqi2LaLje+lKy+CiOqAp
	59ff7548USwXVGAbPdTJRCP6EIhJwcqEk
X-Received: by 2002:a17:90b:4a90:b0:38d:b36e:9813 with SMTP id
 98e67ed59e1d1-396d0f8e9f9mr8680266a91.11.1787895949284; Thu, 27 Aug 2026
 22:45:49 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:45:48 -0700
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Aug 2026 22:45:48 -0700
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Aug 2026 22:45:48 -0700
X-Gm-Features: AcwNN1VdPnnVGgIILuxvEpWACgb0lEUjH2IymnRAvhNewQKszT0MbM0jhqgbw94
Message-ID: <CA+0ovChOY+cRnRkfRWr5X9gcdXsz_L6BkBpXvL6=zdFBWFfUwg@mail.gmail.com>
Subject: [BUG] general protection fault in orangefs_writepages
To: Mike Marshall <hubcap@omnibond.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Cc: falemi@asu.edu, devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/176-general-protection-fault-in-orangefs-writepages/

  Oops: general protection fault, probably for non-canonical address
0xdffffc0000000002: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:orangefs_writepages_callback fs/orangefs/inode.c:144 [inline]
  RIP: 0010:orangefs_writepages+0x642/0xc60 fs/orangefs/inode.c:205
  Call Trace:
   orangefs_writepages+0x642/0xc60 fs/orangefs/inode.c:205
   do_writepages+0x328/0x550 mm/page-writeback.c:2571
   filemap_write_and_wait_range+0x332/0x3f0 mm/filemap.c:685
   orangefs_flush+0x44/0x60 fs/orangefs/file.c:566
   filp_flush+0xbd/0x190 fs/open.c:1467
   filp_close+0x1d/0x40 fs/open.c:1480
   close_files fs/file.c:494 [inline]
   put_files_struct+0x1b6/0x340 fs/file.c:509
   do_exit+0x6a8/0x2360 kernel/exit.c:971

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
