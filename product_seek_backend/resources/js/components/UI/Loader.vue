<template>
	<div class="loader-admin">
		 <div class="infinity">
      <div>
        <span></span>
      </div>
      <div>
        <span></span>
      </div>
      <div>
        <span></span>
      </div>
    </div>
	</div>
</template>
<script>
	export default{
		data(){
			return{

			}
		}
	}
</script>
<style scoped>
.loader-admin{
	width: 110%;
	height: 110%;
	display: flex;
	align-items: center;
	justify-content: center;
	position: fixed;
	z-index: 9999999999999;
	background: rgba(255,255,255,1);
	margin-top: -6%;
	margin-left: -22%;
}
.infinity {
  width: 120px;
  height: 60px;
  position: relative;
}
.infinity div,
.infinity span {
  position: absolute;
}
.infinity div {
  top: 0;
  left: 50%;
  width: 60px;
  height: 60px;
  -webkit-animation: rotate 6.9s linear infinite;
          animation: rotate 6.9s linear infinite;
}
.infinity div span {
  left: -8px;
  top: 50%;
  margin: -8px 0 0 0;
  width: 16px;
  height: 16px;
  display: block;
  background: #8C6FF0;
  box-shadow: 2px 2px 8px rgba(140, 111, 240, 0.09);
  border-radius: 50%;
  -webkit-transform: rotate(90deg);
          transform: rotate(90deg);
  -webkit-animation: move 6.9s linear infinite;
          animation: move 6.9s linear infinite;
}
.infinity div span:before, .infinity div span:after {
  content: '';
  position: absolute;
  display: block;
  border-radius: 50%;
  width: 14px;
  height: 14px;
  background: inherit;
  top: 50%;
  left: 50%;
  margin: -7px 0 0 -7px;
  box-shadow: inherit;
}
.infinity div span:before {
  -webkit-animation: drop1 .8s linear infinite;
          animation: drop1 .8s linear infinite;
}
.infinity div span:after {
  -webkit-animation: drop2 .8s linear infinite .4s;
          animation: drop2 .8s linear infinite .4s;
}
.infinity div:nth-child(2) {
  -webkit-animation-delay: -2.3s;
          animation-delay: -2.3s;
}
.infinity div:nth-child(2) span {
  -webkit-animation-delay: -2.3s;
          animation-delay: -2.3s;
}
.infinity div:nth-child(3) {
  -webkit-animation-delay: -4.6s;
          animation-delay: -4.6s;
}
.infinity div:nth-child(3) span {
  -webkit-animation-delay: -4.6s;
          animation-delay: -4.6s;
}

@-webkit-keyframes moveSvg {
  0% {
    offset-distance: 0%;
  }
  25% {
    background: #5628EE;
  }
  75% {
    background: #23C4F8;
  }
  100% {
    offset-distance: 100%;
  }
}

@keyframes moveSvg {
  0% {
    offset-distance: 0%;
  }
  25% {
    background: #5628EE;
  }
  75% {
    background: #23C4F8;
  }
  100% {
    offset-distance: 100%;
  }
}
@-webkit-keyframes rotate {
  50% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg);
    margin-left: 0;
  }
  50.0001%,
    100% {
    margin-left: -60px;
  }
}
@keyframes rotate {
  50% {
    -webkit-transform: rotate(360deg);
            transform: rotate(360deg);
    margin-left: 0;
  }
  50.0001%,
    100% {
    margin-left: -60px;
  }
}
@-webkit-keyframes move {
  0%,50% {
    left: -8px;
  }
  25% {
    background: #5628EE;
  }
  75% {
    background: #23C4F8;
  }
  50.0001%,
    100% {
    left: auto;
    right: -8px;
  }
}
@keyframes move {
  0%,50% {
    left: -8px;
  }
  25% {
    background: #5628EE;
  }
  75% {
    background: #23C4F8;
  }
  50.0001%,
    100% {
    left: auto;
    right: -8px;
  }
}
@-webkit-keyframes drop1 {
  100% {
    -webkit-transform: translate(32px, 8px) scale(0);
            transform: translate(32px, 8px) scale(0);
  }
}
@keyframes drop1 {
  100% {
    -webkit-transform: translate(32px, 8px) scale(0);
            transform: translate(32px, 8px) scale(0);
  }
}
@-webkit-keyframes drop2 {
  0% {
    -webkit-transform: translate(0, 0) scale(0.9);
            transform: translate(0, 0) scale(0.9);
  }
  100% {
    -webkit-transform: translate(32px, -8px) scale(0);
            transform: translate(32px, -8px) scale(0);
  }
}
@keyframes drop2 {
  0% {
    -webkit-transform: translate(0, 0) scale(0.9);
            transform: translate(0, 0) scale(0.9);
  }
  100% {
    -webkit-transform: translate(32px, -8px) scale(0);
            transform: translate(32px, -8px) scale(0);
  }
}

</style>